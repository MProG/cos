class BinReaderService
  attr_reader :file, :value_in_sec, :min_value, :max_value, :data_size

  def initialize(file)
    @file = file
  end

  def read
    values = []
    data = []
    time = 0
 
    return unless file.read(4) == "TMB1"
    file_params

    data_size.times do
      values << read_float
    end

    values.each do |value|
      data << [time, value]
      time = time + value_in_sec
    end

    {data: data, max_value: max_value, min_value: min_value, values: values}
  end

  private

  def file_params
    n_pipe = read_int
    n_points = read_int
    n_spectr = read_int
    f_sreza = read_int
    f_rezreshenie = read_float
    time_block = read_float
    total_time = read_int
    users_n_block = read_int
    @data_size = read_int
    system_n_block = read_int
    @max_value = read_float
    @min_value = read_float
    @value_in_sec = 1.0 / n_points
  end

  def read_int
    file.read(4).unpack("L").first
  end

  def read_float
    file.read(4).unpack("F").first
  end
end