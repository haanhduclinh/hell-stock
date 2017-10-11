module HellStock
  module Helper
    module_function

    def random_select(array)
      max_index_size = array.size - 1
      index = rand(0..max_index_size)
      array[index]
    end
  end
end
