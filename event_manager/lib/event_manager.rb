# frozen_string_literal: false

require 'csv'
require 'google/apis/civicinfo_v2' 
require 'erb' 

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4] 
end

def clean_phone_number(phone_number)
  phone_number.gsub!(/[^0123456789]/, '')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == '1'
    phone_number[1..10]
  else
    phone_number = ''
  end
end

def freq_metrics(date_arr, time_arr)
  freq_day = date_arr.max_by{|o| date_arr.count(o)}
  freq_time = time_arr.max_by{|o| time_arr.count(o)}
  print "The most frequent registration hour is: #{freq_time}.\nThe most frequent day is: #{freq_day}.\n"
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels:  'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representative by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id, form_letter)
  # making a directory to save letters
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "Event Manager Initialized!"


contents = CSV.open(
  "../event_attendees_full.csv",
  headers: true,             
  header_converters: :symbol 
)

template_letter = File.read('../letter_template.erb')
erb_template = ERB.new(template_letter)

day_freq_array = Array.new
time_freq_array = Array.new
days = { 0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday",6 => "Saturday"}


contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  reg_date = DateTime.strptime(row[:regdate], '%m/%d/%Y %H:%M')

  day = days[reg_date.wday]

  day_freq_array << day
  time_freq_array << reg_date.hour

  legislators = legislators_by_zipcode(zipcode)

  filling in the template for each name
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

freq_metrics(day_freq_array, time_freq_array)
