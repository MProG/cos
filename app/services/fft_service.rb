class FftService
  attr_reader :signal, :buffersize, :spectrum, :sin_lookup, :cos_lookup, :reverse

  def initialize(graph, buffersize = 2048)
    raise Exception if buffersize.odd?
    @buffersize = buffersize
    @signal = graph.values.first(buffersize)

    build_reverse_table
    build_trig_tables
  end

  def call
    fft
  end

  private

  def step_width
    @_step_width ||= Graph.last.values_in_sec / buffersize
  end

  def fft
    real = []
    imag = Array.new(buffersize, 0.0)
    buffersize.times { |i| real[i] = signal[reverse[i]] }

    # here begins teh Danielson-Lanczos section
    halfsize = 1
    while halfsize < buffersize
      phase_shift_step_real = cos_lookup[halfsize]
      phase_shift_step_imag = sin_lookup[halfsize]
      current_phase_shift_real = 1.0
      current_phase_shift_imag = 0.0
      halfsize.times do |fft_step|
        i = fft_step
        while i < buffersize
          off = i + halfsize
          tr = (current_phase_shift_real * real[off]) - (current_phase_shift_imag * imag[off])
          ti = (current_phase_shift_real * imag[off]) + (current_phase_shift_imag * real[off])
          real[off] = real[i] - tr
          imag[off] = imag[i] - ti
          real[i] += tr
          imag[i] += ti

          i += halfsize << 1
        end
        tmp_real = current_phase_shift_real
        current_phase_shift_real = (tmp_real * phase_shift_step_real) - (current_phase_shift_imag * phase_shift_step_imag)
        current_phase_shift_imag = (tmp_real * phase_shift_step_imag) + (current_phase_shift_imag * phase_shift_step_real)
      end

      halfsize = halfsize << 1
    end

    create_result_values(real, imag)
  end

  def create_result_values(real, imag)
    y_values = []
    x_values = []
    result = []
    (buffersize / 2).times do |i|
      y_value = (2 * Math.sqrt(real[i]**2 + imag[i]**2) / buffersize).round(2)
      x_value = step_width * i
      result << [x_value, y_value]
    end
    result
  end

  def build_reverse_table
    @reverse = [0]
    limit = 1
    bit = buffersize / 2

    while limit < buffersize
      limit.times do |i|
        @reverse[i + limit] = @reverse[i] + bit
      end
      limit *= 2
      bit /= 2
    end
  end

  def build_trig_tables
    @sin_lookup = []
    @cos_lookup = []
    buffersize.times do |i|
      veriable = Math::PI / i
      @sin_lookup[i] = Math.sin(- veriable)
      @cos_lookup[i] = Math.cos(- veriable)
    end
  end

  def dft
    real = Array.new(signal.length / 2, 0)
    imag = Array.new(signal.length / 2, 0)
    res = []

    const_val = 2 * Math::PI / buffersize

    (buffersize / 2).times do |k|
      buffersize.times do |n|
        argument = const_val * k * n
        real[k] += signal[n] * Math.cos(argument)
        imag[k] += signal[n] * -Math.sin(argument)
      end
      res << 2 * Math.sqrt(real[k]**2 + imag[k]**2) / buffersize
    end

    res
  end

  def generate_test_signal
    res = []
    buffersize.times do |i|
      x = i * 0.0025
      res << (Math.sin(10 * 2 * Math::PI * x) + (0.5 * Math.sin(5 * 2 * Math::PI * x)))
    end
    res
  end
end
