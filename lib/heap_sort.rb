require_relative "heap"

class Array
  def heap_sort!
    array = self.dup
    (self.length).times do |i|
    BinaryMinHeap.heapify_up(array, array.length - i, array.length)
    end 
    heap = BinaryMinHeap.new(array)
    (self.length).times do
      self.shift
      self.push(heap.extract)
    end 
  end
end
