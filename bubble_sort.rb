def bubble_sort arr
  arr_length = arr.length - 1
  return arr if (arr_length + 1) < 2

  while true do
    change = false
    arr_length.times do |idx|
      if arr[idx] > arr[idx + 1]
          arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
          change = true
      end
    end
    break if change == false
  end
  arr
end

test_arr = [4,3,78,2,0,2]
test_arr2 = [11,5,7,6,15]
print bubble_sort(test_arr)
print bubble_sort(test_arr2)
