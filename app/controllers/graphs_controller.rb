class GraphsController < ApplicationController
  before_action :find_graph, only: [:show, :destroy]

  def index
    @graphs = Graph.all
  end

  def create 
  end

  def destroy
    @graph.destroy
    redirect_to graphs_path
  end

  def show
    @graph_data = GraphBuilderService.new(@graph).build
  end

  def new
  end

  private

  def find_graph
    @graph = Graph.find(params[:id])
  end
end