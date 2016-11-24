class GraphListsController < ApplicationController
  def index
    @charts = []
    @charts << GraphBuilderService.new.multi_chart(Graph.all)

    Graph.all.each do |graph|
      @charts << GraphBuilderService.new.build(graph)
    end

    @charts
  end
end
