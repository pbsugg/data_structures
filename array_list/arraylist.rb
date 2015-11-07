require_relative "../fixed_array/fixed_array.rb"


class ArrayList

  attr_reader :container

  # function to create new
  def initialize(size)
    @container = FixedArray.new(size)
  end

  def size
    @container.size
  end

  def space
    @container.space
  end

  # needed to use "times" do avoid over-reaching into the array
  def add(element)
    add_space if space == 0
    size.times do |index|
      if @container.get(index) == nil
        @container.set(index, element)
        break
      end
    end
    element
  end

  def get(index)  
    if index >= 0 && index < size
      @container.get(index)
    else
      "index out of range"
    end
  end

  def set(index, element)
      @container.set(index, element)
  end

  # put element in existing position, take everything and shift it down one

  def insert(index,element)

    element_on_deck = nil
    loop do
      element_on_deck ? element = element_on_deck : element
      element_on_deck = @container.get(index)
      @container.set(index, element)
      index += 1
      add_space if index == (size - 1)
      break if element_on_deck == nil
    end

  end

  private

  # create a new array (double in size) and copy old stuff over
  # need to preserve indexes, so have to copy old stuff in at beginning
  def add_space
    old_size = size
    new_size = size * 2
    holding_container = FixedArray.new(new_size)
    old_size.times do |index|
      item = @container.get(index)
      next if item == nil
      holding_container.set(index, item)
    end
    @container = holding_container
  end

end
