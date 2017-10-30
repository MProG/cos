class GraphsController < ApplicationController
  before_action :find_graph, only: [:show, :destroy]

  def index
    @graphs = Graph.all
  end

  def destroy
    @graph.destroy
    redirect_to graphs_path
  end

  def show
    @graph_data = GraphBuilderService.new.build(@graph)
    @integral_graph = integral_service.build
    @second_integral_graph = integral_service.second_build
  end

  def new; end

  private

  def integral_service
    @_integral_service ||= IntegralBuilderService.new(@graph)
  end

  def find_graph
    @graph = Graph.find(params[:id])
  end
end
