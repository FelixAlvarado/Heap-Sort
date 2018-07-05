require_relative 'heap'

def k_largest_elements(array, k)
    length = array.length
    array2 = array.dup
    length.times do |i|
        BinaryMinHeap.heapify_down(array2, i, length)
    end 
    heap = BinaryMinHeap.new(array2)
    (length).times do
      array.shift
      array.push(heap.extract)
    end 
    array.drop(length - k)
end
