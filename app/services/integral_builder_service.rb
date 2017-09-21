class IntegralBuilderService
  attr_reader :graph

  def build(graph)
    data = graph_data(graph)
    GraphCreateService.new.write_graph(data[:data], graph.name, math_values(data[:values]))
  end

  private

  def graph_data(graph)
    point_y = 0.0
    data = []
    point_x = 0
    new_values = []

    step = 1.0 / graph.values_in_sec

    graph.values.each do |value|
      point_x += value * step
      data << [point_y, point_x]
      new_values << point_x
      point_y += step
    end

    { data: data, values: new_values }
  end

  def math_values(values)
    max = values.max
    min = values.min
    values_sum = values.map{ |i| i**2 }.sum
    srm = Math.sqrt(values_sum / values.count)
    "Max: #{max} ; Min: #{min} ; Размах: #{max - min} ; СКР: #{srm} ; Пик фактор: #{max - srm}"
  end
end
