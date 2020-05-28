
def my_each
   array_enum = is_a?(Range) ? to_a : self
   result = ''
   i = 0
   if block_given?
     while i < array_enum.size
       yield(array_enum[i])
       i += 1
     end
   else
     result = array_enum.to_enum
   end
   !result.is_a?(Enumerator) ? array_enum : result
 end


  def my_each_with_index
    array_enum = is_a?(Range) ? to_a : self
    i = 0
    result = ''
    if block_given?
      while i < array_enum.size
        yield(array_enum[i], i)
        i += 1
      end
    else
      result = array_enum.to_enum :each_with_index
    end
    !result.is_a?(Enumerator) ? array_enum : result
  end
