class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(store = [], &prc)
    @prc = prc
    @store = store
  end

  def count
    @store.length
  end

  def extract
    result = @store.first
    @store[0], @store[-1] = @store[-1], @store[0]
    @store.delete(@store.last)
    BinaryMinHeap.heapify_down(@store,0,@store.length)
    result
  end

  def peek
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length)
  end

  public
  def self.child_indices(len, parent_index)
    num1 = parent_index * 2 + 1
    num2 = parent_index * 2 + 2
    result = [];
    result.push(num1) if num1 < len
    result.push(num2) if num2 < len
    result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|x,y| x <=> y}
    current_index = parent_idx
    while BinaryMinHeap.child_indices(len, current_index).length > 0
      indices = BinaryMinHeap.child_indices(len, current_index)
      change = 0
      if indices.length == 2
        if prc.call(array[indices[0]], array[indices[1]]) == -1
          index = indices[0] 
        else 
          index = indices[1]
        end
      else 
        index = indices[0] 
      end 
        # index = array[indices[0]] < array[indices[1]] ? indices[0] : indices[1]
        if prc.call(array[current_index], array[index]) == 1
          array[current_index], array[index] = array[index], array[current_index]
          current_index = index
          change += 1
       end 
       break if change == 0
    end 
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|x,y| x <=> y}
    current_index = child_idx
    while current_index > 0
      next_index = BinaryMinHeap.parent_index(current_index)
      if prc.call(array[current_index], array[next_index]) == -1
        array[current_index], array[next_index] = array[next_index], array[current_index]
        current_index = next_index
        next 
      end 
      break
    end
    array 
  end
end
