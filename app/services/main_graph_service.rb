class MainGraphService

  def write_graph(data)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.subtitle(text: 'heh')
      f.title(text: "My chart")
      f.xAxis(type: 'time')
      f.yAxis(title: { text: 'Exchange rate'})
      f.legend(enabled: false)
      f.series(type: 'area', name: "Population in Millions", data: data)
      f.chart(zoomType: 'x')

      f.plotOptions(
        area: {
            fillColor: {
                linearGradient: {
                    x1: 0,
                    y1: 0,
                    x2: 0,
                    y2: 1
                },
                stops: [
                    [0, "#7cb5ec"],
                    [1, "rgba(124,181,236,0)"]
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
end


