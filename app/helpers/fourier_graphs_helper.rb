module FourierGraphsHelper
  WINDOW_SIZE = [512, 1024, 2048, 4096, 8192, 16_384].freeze

  def window_size_list(max_value)
    WINDOW_SIZE.select { |value| value < max_value }
  end
end
