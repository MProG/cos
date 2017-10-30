class IntegralBuilderService
  attr_reader :graph, :first_values

  def initialize(graph)
    @graph = graph
  end

  def build
    GraphCreateService.new.write_graph(first_integral[:data], graph.name, math_values(first_integral[:values]))
  end

  def second_build
    second_values = graph_data(first_integral[:values])
    GraphCreateService.new.write_graph(second_values[:data], graph.name, math_values(second_values[:values]))
  end

  private

  def first_integral
    @_first_integral ||= graph_data(@graph.values)
  end

  def graph_data(values)
    point_x = 0.0
    data = []
    point_y = 0
    new_values = []

    values.each do |value|
      point_y += value * step
      data << [point_x, point_y]
      new_values << point_y
      point_x += step
    end

    { data: data, values: new_values }
  end

  def step
    @_step ||= 1.0 / graph.values_in_sec
  end

  def math_values(values)
    max = values.max
    min = values.min
    values_sum = values.map { |i| i**2 }.sum
    srm = Math.sqrt(values_sum / values.count)
    "Max: #{max} ; Min: #{min} ; Размах: #{max - min} ; СКР: #{srm} ; Пик фактор: #{max - srm}"
  end
end
