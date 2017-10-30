class FourierGraphsController < ApplicationController
  def show
    @graph_size = Graph.find(params[:id]).values.length
    @data_path = fourier_graph_datum_path(params[:id])
  end
end
