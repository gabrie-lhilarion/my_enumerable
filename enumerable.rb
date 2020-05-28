
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


  def my_select
    array_enum = is_a?(Range) ? to_a : self
    res_array = []
    result = ''
    if block_given?
      array_enum.my_each do |item|
        res_array << item if yield(item)
      end
    else
      result = array_enum.to_enum :select
    end
    !result.is_a?(Enumerator) ? res_array : result
  end

  def my_all?(*args, &block)
    array_enum = is_a?(Range) ? to_a : self
    flag = true
    if array_enum.empty?
      flag = true
    elsif !args[0].nil? && args[0].class == Class
      array_enum.my_each { |item| flag = false unless item.is_a?(args[0]) }
    elsif !args[0].nil?
      if args[0].is_a?(Regexp)
        array_enum.my_each { |item| flag = false unless args[0].match(item) }
      else
        array_enum.my_each { |item| flag = false unless item == args[0] }
      end
    elsif !block.nil?
      array_enum.my_each { |item| flag = false unless block.call(item) }
    else
      array_enum.my_each { |item| flag = false unless item }
    end
    flag
  end



  def my_any?(*args, &block)
    array_enum = is_a?(Range) ? to_a : self
    flag = false
    if array_enum.empty?
      flag = false
    elsif !args[0].nil? && args[0].class == Class
      array_enum.my_each { |item| flag = true if item.is_a?(args[0]) }
    elsif !args[0].nil?
      if args[0].is_a?(Regexp)
        string_regex = array_enum.join(' ')
        flag = true if string_regex =~ args[0]
      else
        array_enum.my_each { |item| flag = true if item == args[0] }
      end
    elsif !block.nil?
      array_enum.my_each { |item| flag = true if block.call(item) }
    else
      array_enum.my_each { |item| flag = true if item }
    end
    flag
  end


  def my_none?(*args, &block)
    array_enum = is_a?(Range) ? to_a : self
    flag = true
    if array_enum.empty?
      flag = true
    elsif !args[0].nil? && args[0].class == Class
      array_enum.my_each { |item| flag = false if item.is_a?(args[0]) }
    elsif !args[0].nil?
      if args[0].is_a?(Regexp)
        string_regex = array_enum.join(' ')
        flag = false if string_regex =~ args[0]
      else
        array_enum.my_each { |item| flag = false if item == args[0] }
      end
    elsif !block.nil?
      array_enum.my_each { |item| flag = false if block.call(item) }
    else
      array_enum.my_each { |item| flag = false if item }
    end
    flag
  end


  def my_count(*args, &block)
    array_enum = is_a?(Range) ? to_a : self
    count = 0
    if block.nil? && args[0].nil?
      array_enum.my_each { |item| count += 1 if item }
    elsif block.nil? && !args[0].nil?
      array_enum.my_each { |item| count += 1 if item == args[0] }
    else
      array_enum.my_each { |item| count += 1 if block.call(item) }
    end
    count
  end

  def my_map(proc_map = nil)
    array_enum = is_a?(Range) ? to_a : self
    res_array = []
    if (block_given? && !proc_map.nil?) || !proc_map.nil?
      array_enum.my_each do |item|
        res_array << proc_map.call(item)
      end
    elsif block_given?
      array_enum.my_each do |item|
        res_array << yield(item)
      end
    else
      result = array_enum.to_enum :map
    end
    !result.is_a?(Enumerator) ? res_array : result
  end


    def my_inject(*args, &proc)
      array_enum = is_a?(Range) ? to_a : self
      value = 0
      if array_enum[0].is_a?(Integer)
        if args.size == 2 && !block_given?
          op = args[1].to_s
          value = args[0].to_i
          array_enum.my_each do |item|
            value = value.to_i.send(op, item)
          end
        elsif args.size == 1 && !block_given?
          op = args[0].to_s
          case op
          when '*'
            value = 1
          when '+'
            value = 0
          end
          array_enum.my_each do |item|
            value = value.to_i.send(op, item)
          end
        elsif args.size == 1 && block_given?
          value = args[0].to_i
          array_enum.my_each do |item|
            value = yield(value, item)
          end
        elsif args.size.zero? && block_given?
          array_enum.my_each do |item|
            value = yield(value, item)
          end
        end
      else
        array_enum.my_each { |item| value = proc.call(value.to_s, item.to_s) }
      end
      value
    end
