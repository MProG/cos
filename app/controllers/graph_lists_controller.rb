class GraphListsController < ApplicationController
  def index
    chart_list(Graph.all)
  end

  def create
    if params[:file]
      file_names = FileReaderService.new(params[:file]).read
      graphs = Graph.where(name: file_names)
    else
      graphs = Graph.all
    end
    chart_list(graphs)
    render :index
  end

  private

  def chart_list(graphs)
    @charts = [GraphBuilderService.new.multi_chart(graphs)]

    graphs.each do |graph|
      @charts << GraphBuilderService.new.build(graph)
    end
  end
end
