class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new do |el1, el2|
      el1 <=> el2
    end
  end

  def count
    @store.length
  end

  def extract
    temp = @store[0]
    @store[0] = @store[@store.length-1]
    @store[@store.length-1] = temp
    @store.pop
    @store = self.class.heapify_down(@store, 0)
    temp
  end

  def peek
    @store
  end

  def push(val)
    @store.push(val)
    @store = self.class.heapify_up(@store, @store.length-1) unless @store.length == 1
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    ans = []
    left = parent_index*2+1
    right = parent_index*2+2
    ans << left if left < len
    ans << right if right < len
    return ans
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new do |el1, el2|
      el1 <=> el2
    end

    indices = self.child_indices(len, parent_idx)

    if indices.length == 0
      return array
    elsif indices.length == 1
      child_idx = indices[0]
    else
      left = array[indices[0]]
      right = array[indices[1]]
      child_idx = prc.call(left,right) == -1 ? indices[0] : indices[1]
    end

    if prc.call(array[child_idx],array[parent_idx]) == -1
      temp = array[child_idx]
      array[child_idx] = array[parent_idx]
      array[parent_idx] = temp
    end
    self.heapify_down(array, child_idx, len, &prc)
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new do |el1, el2|
      el1 <=> el2
    end

    parent_idx = self.parent_index(child_idx)

    if prc.call(array[child_idx],array[parent_idx]) == -1
      temp = array[child_idx]
      array[child_idx] = array[parent_idx]
      array[parent_idx] = temp
    end
    self.heapify_down(array, parent_idx, len, &prc)
    self.heapify_up(array, parent_idx, len, &prc) unless parent_idx == 0
    array
  end
end
