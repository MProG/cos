class FourierGraphDataController < ApplicationController
  layout false
  before_action :find_graph, :window_size

  def show
    render json: fft_service.call
  end

  private

  def fft_service
    @_fft_service ||= FftService.new(@graph, window_size.to_i)
  end

  def find_graph
    @graph = Graph.find(params[:id])
  end

  def window_size
    @window_size = params[:window_size] || 2048
  end
end
