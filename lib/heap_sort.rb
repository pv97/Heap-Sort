require_relative "heap"
require 'byebug'
class Array
  def heap_sort!
    # debugger
    idx = 1
    while idx < self.length
      BinaryMinHeap.heapify_up(self,idx,idx) do |el1, el2|
        -1*(el1 <=> el2)
      end
      idx += 1
    end

    while idx > 0
      BinaryMinHeap.heapify_down(self,0,idx) do |el1, el2|
        -1*(el1 <=> el2)
      end
      self[0], self[idx-1] = self[idx-1], self[0]
      idx -= 1
    end
    self
  end
end
