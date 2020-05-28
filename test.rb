# CyclomaticComplexity Bug
# rubocop:disable Style/BlockComments
=begin
require './enumerable.rb'

test_array1 = [11, 2, 3, 56]

test_array2 = %w[a b c d]

true_array = [1, true, 'hi', []]

false_array = [nil, false, nil, false]

words = %w[dog door rod blade]

# my_each

p 'my_each'

test_array1.my_each { |x| p x }

test_array2.my_each { |x| p x }

p test_array2.my_each

array = [1, 2, 3, 5, 1, 7, 3, 4, 5, 7, 2, 3, 2, 0, 8, 8, 7, 8, 1, 6, 1, 1, 7, 2, 1, 2, 5, 8, 6, 0, 4, 5, 8, 2, 2, 5, 4,
         7, 3, 4, 3, 3, 8, 5, 1, 0, 3, 7, 5, 5, 7, 2, 6, 7, 7, 0, 4, 4, 0, 2, 0, 6, 6, 8, 1, 6, 8, 6, 2, 3, 6, 1, 5, 2,
         6, 7, 2, 5, 8, 2, 0, 7, 3, 2, 3, 6, 1, 2, 8, 3, 7, 0, 5, 0, 0, 2, 6, 1, 5, 2]

my_each_output = ''

block = proc { |num| my_each_output += num.to_s }

array.my_each(&block)

p my_each_output

# my_each_with_index

p 'my_each-with_index'

test_array1.my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }

p test_array2.my_each_with_index

# my_select

p 'my_select'
p test_array1.my_select(&:even?)
p test_array2.my_select { |x| x == 'c' }
p [1,2,3,4,5].my_select { |num| num.even? } #should return [2, 4]
p [1,2,3,4,5].my_select { |num| num.odd? } # should return [1, 3, 5]
p [1,2,3,4,5].my_select { |num| num > 4 } # should return [5]
p test_array2.my_select

# my_all?

p 'my_all?'

p (%w[ant bear cat]).my_all? { |word| word.length >= 3 } #=> true

p (%w[ant bear cat]).my_all? { |word| word.length >= 4 } #=> false

p %w[ant bear cat].my_all?(/t/)

p [1, 2].my_all?(Numeric) # true

p [1, 2].my_all?(String) # false

p [1, 2].my_all?(1) # false

p [1, 1].my_all?(1) # true

p true_array.my_all? #true

p words.my_all?(/d/) #true

p %w[ant bear cat].my_all?(/t/) # should return false

p %w[ant tiger cat].my_all?(/t/) # should return true

p "======================="

# my_any?
p 'my_any?'

p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true

p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true

p %w[ant bear cat].my_any?(/d/) #=> false
p [nil, true, 99].my_any?(Integer) #=> true
p [nil, true, 99].my_any? #=> true
p [].my_any? #=> false

p [1, 2, 3, 's'].my_any?(String) #=> true

p [1, 2, 3, 's'].my_any?(Numeric) #=> true

p [1, 2, 3].my_any?(String) #=> false

p [1, 2].my_any?(1) # true
p [1, 1].my_any?(1) # true

p false_array.my_any? #false

p words.my_any?(/d/) #true

p "======================="

# my_none?

p 'my_none?'

p %w[ant bear cat].my_none?(/d/) #=> true

p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
p [1, 3.14, 42].my_none?(Float) #=> false

p [].my_none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false
p [1, 2, 3].my_none?(1) #=> false
p [1, 2, 3].my_none?(4) #=> true
p [nil, false, nil, false].my_none? # true

p words.my_none?(/d/) #false

# my_count

p 'my_count'

ary = [1, 2, 4, 2]
p ary.my_count #=> 4
p ary.my_count(9) #=> 0
p ary.my_count(2) #=> 2
p ary.my_count(&:even?) #=> 3

# # my_map

p 'my_map'

arr = [1, 2, 7, 4, 5]

p arr.my_map { |x| x * x }
p (1..2).my_map { |x| x * x }

# # my_map block
p arr.my_map { |x| x * x }

# # my_map proc
myMapP = Proc.new { |x| x * x }
p arr.my_map (myMapP)

# # my_map proc and block
myMapP = Proc.new { |x| x * 2 }
p arr.my_map (myMapP) { |x| x * x}

p array.my_map

# my_inject
p 'my_inject'

# Sum some numbers
p (5..10).my_inject(:+) #=> 45
# Same using a block and inject
p (5..10).my_inject { |sum, n| sum + n } #=> 45
# Multiply some numbers
p (5..10).my_inject(1, :*) #=> 151200
# Same using a block
p (5..10).my_inject(1) { |product, n| product * n } #=> 151200

search = proc { |memo, word| memo.length > word.length ? memo : word }
p ['hello','strong','am'].my_inject(&search) # => "strong"

# multiply_els

def multiply_els(arg)
  arg.my_inject(1, :*)
end

p multiply_els([2, 4, 5])

=end
# rubocop:enable Style/BlockComments
