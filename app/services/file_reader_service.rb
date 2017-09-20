class FileReaderService
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def read
    file_names = []
    file.read.each_line do |line|
      file_names << line.gsub!(/\r\n/, '')
    end

    file_names
  end
end
