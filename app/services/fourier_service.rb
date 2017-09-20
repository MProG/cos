class FourierService
  # option_parser = OptionParser.new do |opts|
  #   opts.banner = "Usage: ruby fourier_transform.rb -n buffersize -f frequency [-r samplerate] [-w sine|triangle|square|saw] [--plot] [--benchmark]"
  #   opts.on("-n", "--buffersize N", Integer, "Specify buffer size of N samples") do |n|
  #     options[:buffersize] = n
  #   end
  #   opts.on("-f", "--frequency FREQUENCY", "Specify the frequency of the generated signal in Hz") do |f|
  #     options[:frequency] = f.to_f
  #   end
  #   opts.on("-r", "--samplerate SAMPLERATE", Float, "Specify the sample rate of the generated signal") do |r|
  #     options[:samplerate] = r
  #   end
  #   opts.on("-w", "--waveform WAVEFORM", "Specify the shape of the waveform. sine (default), triangle, square, or saw") do |wave|
  #     options[:waveform] = wave.to_sym if ['sine', 'triangle', 'square', 'saw'].include?(wave)
  #   end
  #   opts.on("--dft", "Perform a Discrete Fourier Transform (slower)") do
  #     options[:transform] = :dft
  #   end
  #   opts.on("--plot", "Plot a graph of the Fourier Transform") do |plot|
  #     options[:plot] = plot
  #   end
  #   opts.on("--benchmark", "Benchmark DFT vs FFT") do |b|
  #     options[:benchmark] = b
  #   end
  #   opts.on_tail("-h", "--help", "Show this message") do
  #       puts opts
  #       exit
  #   end
  # end

  def fft(vec)
    return vec if vec.size <= 1

    even = Array.new(vec.size / 2) { |i| vec[2 * i] }
    odd  = Array.new(vec.size / 2) { |i| vec[2 * i + 1] }

    fft_even = fft(even)
    fft_odd  = fft(odd)

    fft_even.concat(fft_even)
    fft_odd.concat(fft_odd)

    Array.new(vec.size) { |i| fft_even[i] + fft_odd [i] * omega(-i, vec.size) }
  end

  # calculate individual element of FFT matrix:  (e ^ (2 pi i k/n))
  # fft_matrix[i][j] = omega(i*j, n)
  #
  def omega(k, n)
    Math::E**Complex(0, 2 * Math::PI * k / n)
  end

  # attr_reader :spectrum, :bandwidth, :samplerate, :buffersize, :data

  # def initialize(data, samplerate = nil)
  #   @buffersize = data.length
  #   @data = data
  #   @samplerate = samplerate || 2048
  #   @bandwidth = (2.0 / @buffersize) * (@samplerate / 2.0)
  #   @spectrum = Array.new

  #   build_reverse_table
  #   build_trig_tables
  # end

  # def build_reverse_table
  #   @reverse = Array.new(@buffersize)
  #   @reverse[0] = 0;

  #   limit = 1
  #   bit = @buffersize >> 1

  #   while (limit < @buffersize )
  #     (0...limit).each do |i|
  #       @reverse[i + limit] = @reverse[i] + bit
  #     end

  #     limit = limit << 1
  #     bit = bit >> 1
  #   end
  # end

  # def build_trig_tables
  #   @sin_lookup = []
  #   @cos_lookup = []
  #   (0...@buffersize).each do |i|
  #     @sin_lookup[i] = Math.sin(- Math::PI / i);
  #     @cos_lookup[i] = Math.cos(- Math::PI / i);
  #   end
  # end

  # def fft
  #   buffer = data
  #   raise Exception if buffer.length % 2 != 0

  #   real = []
  #   imag = []

  #   (0...buffer.length).each do |i|
  #     real[i] = buffer[@reverse[i]]
  #     imag[i] = 0.0
  #   end

  #   # here begins teh Danielson-Lanczos section
  #   halfsize = 1
  #   while halfsize < buffer.length
  #     phase_shift_step_real = @cos_lookup[halfsize]
  #     phase_shift_step_imag = @sin_lookup[halfsize]
  #     current_phase_shift_real = 1.0
  #     current_phase_shift_imag = 0.0
  #     (0...halfsize).each do |fft_step|
  #       i = fft_step
  #       while i < buffer.length
  #         off = i + halfsize
  #         tr = (current_phase_shift_real * real[off]) - (current_phase_shift_imag * imag[off])
  #         ti = (current_phase_shift_real * imag[off]) + (current_phase_shift_imag * real[off])
  #         real[off] = real[i] - tr
  #         imag[off] = imag[i] - ti
  #         real[i] += tr
  #         imag[i] += ti

  #         i += halfsize << 1
  #       end
  #       tmp_real = current_phase_shift_real
  #       current_phase_shift_real = (tmp_real * phase_shift_step_real) - (current_phase_shift_imag * phase_shift_step_imag)
  #       current_phase_shift_imag = (tmp_real * phase_shift_step_imag) + (current_phase_shift_imag * phase_shift_step_real)
  #     end

  #     halfsize = halfsize << 1
  #   end

  #   (0...buffer.length/2).each do |i|
  #     @spectrum[i] = 2 * Math.sqrt(real[i] ** 2 + imag[i] ** 2) / buffer.length
  #   end

  #   @spectrum
  # end

  # def index_to_frequency(i)
  #   i * @bandwidth
  # end

  # def frequency_to_index(freq)
  #   (@buffersize.to_f * (freq / @samplerate)).round
  # end

  # def peak_frequency
  #   index = (0...spectrum.length).max {|a, b| spectrum[a] <=> spectrum[b] }
  #   index_to_frequency(index)
  # end
end

# generate a signal to pass to the FourierTransform

# signal = Array.new
# (0...options[:buffersize]).each do |i|
#   step = i * (options[:frequency] / options[:samplerate].to_f) % 1.0
#   case options[:waveform]
#     when :sine # no harmonics
#       signal[i] = Math.sin(step * 2 * Math::PI)
#     when :square # lots of harmonics
#       signal[i] = step < 0.5 ? 1.0 : -1.0
#     when :triangle
#       signal[i] = 1 - 4 * (step.round - step).abs
#     when :saw
#       signal[i] = 2 * (step - step.round)
#   end
# end

# fourier = FourierTransform.new(options[:buffersize], options[:samplerate]).fft(signal)

# if options[:benchmark]
#   fourier
# else
#   fourier.send(options[:transform], signal) # runs either fft or dft transform

#   puts "[#{options[:transform].to_s.upcase}] Sample rate: #{fourier.samplerate/1000}kHz / Buffer size: #{fourier.buffersize} samples / Input: generated #{options[:frequency]}Hz #{options[:waveform].to_s} wave\n\n"
#   puts "      Found fundamental peak frequency of #{fourier.peak_frequency.round_to(2)}Hz +/- #{(fourier.bandwidth/2.0).round_to(2)} (off by #{(options[:frequency] - fourier.peak_frequency).round_to(2).abs}Hz)\n\n"

#   if options[:plot]
#     fourier.plot
#   end
# end
