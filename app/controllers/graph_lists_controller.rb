class GraphListsController < ApplicationController
  def index
    @charts = [] 

    Graph.all.each do |graph|
      @charts << GraphBuilderService.new(graph).build
    end

    @charts
  end
end
