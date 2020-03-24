# rubocop:disable Style/CaseEquality

module Enumerable # :nodoc:
    # frozen_string_literal: true
    # Returns each item individually
    def my_each
      i = 0
      while i < length
        yield(i)
        i += 1
      end
    end
  
    # Returns item + index in array
    def my_each_with_index
      i = 0
      while i < size
        yield(self[i], i)
        i += 1
      end
    end
  
    # Returns items that pass the test
    def my_select
      result = []
      my_each do |item|
        result << item if yield(item)
      end
    end
  
    
  end