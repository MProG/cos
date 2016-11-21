class FileReaderService
	def read
		step = time = value_in_sec = 0
		data = []

		File.open("vendor/PRIM1.TXT", "r").each_line do |line|
		  value = line.gsub!( /\r\n/, "").to_f

		  if step >= 5
		  	data << [time, value.to_f]
		  	time = time + value_in_sec
		  elsif step == 1
		  	value_in_sec = 1.0 / value.to_f
		  end
		  step += 1
		end

		data
	end
end