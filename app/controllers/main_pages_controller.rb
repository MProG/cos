class MainPagesController < ApplicationController
  def index
    data = FileReaderService.new.read()
    @chart = MainGraphService.new.write_graph(data[:data])
  end

  def create
    file = params[:file]
    data = BinReaderService.new(file).read

    @chart = MainGraphService.new.write_graph(data[:data])
    @max_value = data[:max_value]
    @min_value = data[:min_value]
    @srm = Math.sqrt(data[:values].map{|i| i**2}.sum / data[:values].count)
  end
end
