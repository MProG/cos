class GraphCreateService
  def write_graph(data, name, values_attribute)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.subtitle(text: values_attribute)
      f.title(text: name)
      f.xAxis(type: 'time')
      f.yAxis(title: { text: 'Value' })
      f.legend(enabled: false)
      f.series(type: 'line', name: 'Value', data: data)
      f.chart(zoomType: 'x')

      f.plotOptions(
        area: {
          fillColor: {
            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
            stops: [
              [0, '#7cb5ec'],
              [1, 'rgba(124,181,236,0)']
            ]
          },
          marker: {
            radius: nil
          },
          lineWidth: 1,
          states: {
            hover: {
              lineWidth: 1
            }
          },
          threshold: nil
        }
      )
    end
  end

  def write_multiply_graph(data, values_attribute)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.subtitle(text: values_attribute)
      f.title(text: 'Combined Chart')
      f.xAxis(type: 'time')
      f.yAxis(title: { text: 'Value' })
      f.legend(enabled: false)

      data.each do |key, values|
        f.series(type: 'line', name: key.to_s, data: values)
      end

      f.chart(zoomType: 'x')

      f.plotOptions(
        area: {
          fillColor: {
            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
            stops: [
              [0, '#7cb5ec'],
              [1, 'rgba(124,181,236,0)']
            ]
          },
          marker: {
            radius: nil
          },
          lineWidth: 1,
          states: {
            hover: {
              lineWidth: 1
            }
          },
          threshold: nil
        }
      )
    end
  end

  def write_bar_graph(_data)
    categories = ['0-4']

    LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(type: 'column')
      f.subtitle(text: 'heh')
      f.title(text: 'My chart')
      f.xAxis(
        categories: categories,
        reversed: false,
        labels: {
          step: 1
        }
      )
      f.yAxis(
        title: { text: nil }
      )

      f.series(name: 'Value',
               data: [-2.2, -2.2, -2.3, -2.5]
              )

      f.plotOptions(
        series: {
          stacking: 'normal'
        }
      )
    end
  end
end
