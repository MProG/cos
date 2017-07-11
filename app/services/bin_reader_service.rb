class BinReaderService
  attr_reader :file, :step_time, :min_value, :max_value, :data_size, :values_in_sec

  def initialize(file)
    @file = file
  end

  def read
    values = []
    data = []

    return unless file.read(4) == 'TMB1'
    file_params

    data_size.times do
      values << read_float
    end

    { max_value: max_value, min_value: min_value, values: values, values_in_sec: values_in_sec }
  end

  private

  def file_params
    n_pipe = read_int
    @values_in_sec = read_int
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
    @step_time = 1.0 / values_in_sec
  end

  def read_int
    file.read(4).unpack('L').first
  end

  def read_float
    file.read(4).unpack('F').first
  end
end
