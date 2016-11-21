class MainPagesController < ApplicationController
  def index
    data = FileReaderService.new.read()
    @chart = MainGraphService.new.write_graph(data)
  end

  private

  def graph_params
    params.rermit(:max_value)
  end
end
