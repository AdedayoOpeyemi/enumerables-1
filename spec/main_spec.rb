require './bin/main'

RSpec.describe 'Enumerable' do
  let(:numbers) {[1, 2, 3, 4]}
  let(:numbers_nil) {[1, 2, 3, 4, nil]}
  let(:array_str){%w[hola 3244 adios valida 344 _er tambien]}

  describe '.my_each' do
    it 'returns each item with an operation applied' do
      result = []
      numbers.my_each { |n| result << n * 2}
      result2 = []
      numbers.each { |n| result2 << n * 2}
      expect(result).to eql(result2)
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_each).to be_a(Enumerator)
    end
  end

  describe '.my_each_with_index' do
    it '' do
      result = []
      numbers.my_each_with_index { |n, i| result << "#{n}: #{i}"}
      expect(result).to eql(["1: 0", "2: 1", "3: 2", "4: 3"])
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_each_with_index).to be_a(Enumerator)
    end
  end

  describe '.my_select' do
    it 'returns items that return true to the block' do
      expect(numbers.my_select { |n| n > 2 }).to eql(numbers.select { |n| n > 2 })
    end

    it 'returns Enumerator when not passed a block' do
      expect(numbers.my_select).to be_a(Enumerator)
    end
  end

  describe '.my_all' do
    context 'there is a block given' do
      it 'returns true if all elements in array fits the contition' do
        expect(array_str.my_all? { |i| i =~ /./ }).to eq(true)
      end

      it 'returns false if not all elements in array fits the contition' do
        expect(array_str.my_all? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(false)
      end
    end

    context 'there is no block given' do
      it 'will return true if all the items are not nil nor false' do
        expect(numbers.my_all?).to be_truthy
      end

      it 'will return true if all the elements are of a given class' do
        expect(numbers.my_all?(Integer)).to eq(true)
      end

      it 'will return true if all items match regular expression' do
        expect(numbers.my_all?(/\d/)).to eq(true)
      end
    end
  end

  describe '.my_any' do
    context 'there is a block given' do
      it 'returns true if any element in array fits the contition' do
        expect(array_str.my_any? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(true)
      end

      it 'returns false if none of the elements fits the condition' do
        expect(numbers.my_any? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(false)
      end
    end

    context 'there is no block given' do
      it 'will return true if any the items is truthy' do
        expect(numbers_nil.my_any?).to eql(true)
      end

      it 'will return true if any element is of a given class' do
        expect(['s','s',3,'s'].my_any?(Integer)).to eq(true)
      end

      it 'will return true any item match regular expression' do
        expect(array_str.my_any?(/\d/)).to eq(true)
      end
    end
  end

  describe '.my_none' do
    context 'there is a block given' do
      it 'returns true if none of the elements in array fit the contition' do
        expect(numbers.my_none? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(true)
      end

      it 'returns false if any of the elements fit the condition' do
        expect(array_str.my_none? { |i| i =~ /^[a-zA-Z]*$/ }).to eq(false)
      end
    end

    context 'there is no block given' do
      it 'will return true if none of the items is truthy' do
        expect([nil, false].my_none?).to eql(true)
      end

      it 'will return true if any element is of a given class' do
        expect(['s','s','3','s'].my_none?(Numeric)).to eq(true)
      end

      it 'will return true if none if the items match regular expression' do
        expect(numbers.my_none?(/s/)).to eq(true)
      end
    end
  end

  describe '.my_count' do
    context 'block_given' do
      it 'returns the number of elements that meet the condition in the block' do
        expect(numbers.my_count { |n| n > 2 }).to eql(numbers.count { |n| n > 2 })
      end
    end

    context '!block_given' do
      it 'returns the number of elements that match the one passed as argument' do
        expect(numbers.my_count(2)).to eql(numbers.count(2))
      end
    end
  end

  describe '.my_inject' do
    context 'only a symbol passed as argument' do
      it 'returns the cumulative result of the operation applied to all the elements' do
        expect((5..10).my_inject(:*)).to eql((5..10).inject(:*))
      end
    end

    context 'symbol and initial value passed as argument' do
      it 'returns the cumulative result of the operation applied to all the elements, given a initial value' do
        expect((5..10).my_inject(2, :*)).to eql((5..10).inject(2, :*))
      end
    end

    context 'only block passed' do
      it 'returns cumulative result of operations on all items' do
        expect(numbers.my_inject { |r, i| r * i }).to eql(numbers.inject { |r, i| r * i })
      end
    end

    context 'initial value and block passed' do
      it 'returns cumulative result of operations on all items, given a initial value' do
        expect(numbers.my_inject(2) { |r, i| r * i }).to eql(numbers.inject(2) { |r, i| r * i })
      end
    end
  end
end