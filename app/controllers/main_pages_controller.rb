class MainPagesController < ApplicationController
  def create
    file = params[:file]
    data = BinReaderService.new(file).read

    params = {
      values: data[:values],
      max_value: data[:max_value],
      min_value: data[:min_value],
      values_in_sec: data[:values_in_sec],
      name: file.original_filename
    }

    Graph.create(params)
    redirect_to graphs_path
  end
end
