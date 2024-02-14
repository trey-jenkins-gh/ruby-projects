def stock_picker(price_arr)
  b, s, p = 0, 0, 0
  price_arr.each.with_index do |o_value, o_index| # loops over each index from 0 to -1
    # p "Buy Prices & Dates: #{[o_value, o_index, p]}"
    price_arr.each.with_index do |i_value, i_index| # loops over each index from 0 to -1 again
      # p"Sells Prices & Dates: #{[i_value, i_index, p]}"
      if i_index > o_index # compares if the index of the internal loop is greater than the index of the outer loop
        if i_value - o_value > p # checks to see if the value of the current inner loop value - current outer loop value is grater than current p( must be greater than 0 to start)
          p = i_value - o_value # sets p to the value of the inner loop - outer loop
          b = o_index # tracks the index number of the outer loop
          s = i_index # tracks the index number of the inner loop
          # when no other differences can exeed the value of p, everything is static until return
        end
      end
    end
  end
  print "#{[b, s]}\n" # returns the outer loop index => inner loop index that had the greatest differce between held values
end

test_arr = [17, 3, 6, 9, 15, 8, 6, 1, 10]
stock_picker(test_arr) #=> [1, 4] (3, 15)
stock_picker(test_arr.reverse) #=> [1, 8] (1, 17)
