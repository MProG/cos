class GraphBuilderService
  attr_reader :graph

  def initialize(graph)
    @graph = graph
  end

  def build
    data = graph_data
    chart = GraphCreateService.new.write_graph(data[:data], graph.name, math_values(data))

    chart
  end

  private

  def graph_data
    time = 0.0
    data = []

    step = 1.0 / graph.values_in_sec
    values = graph.values

    values.each do |value|
      data << [time, value]
      time = time + step
    end

    {data: data, max_value: values.max, min_value: values.min, values: graph.values}
  end

  def math_values(data)
    max = data[:max_value]
    min = data[:min_value]
    srm = Math.sqrt(data[:values].map{|i| i**2}.sum / data[:values].count)
    "Max: #{max} ; Min: #{min} ; Размах: #{max - min} ; СКР: #{srm} ; Пик фактор: #{max - srm}"
  end
end