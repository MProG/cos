class MainGraphService

  def write_graph(data)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.subtitle(text: 'heh')
      f.title(text: "My chart")
      f.xAxis(type: 'date')
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

  def write_bar_graph(data)

    categories = ['0-4', '5-9', '10-14', '15-19',
                '20-24', '25-29', '30-34', '35-39', '40-44',
                '45-49', '50-54', '55-59', '60-64', '65-69',
                '70-74', '75-79', '80-84', '85-89', '90-94',
                '95-99', '100-101', '101-102', '102-103', '103-104', '104-105', '106','107','108','109','110',
                '111','112','123', '124', '125', '1','2', '3', '4', '5', '6', "7", "8", "9", "10", "11", "12", 
                "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", 
                "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"]

    LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(type: 'column')
      f.subtitle(text: 'heh')
      f.title(text: "My chart")
      f.xAxis(               
        categories: categories,
        reversed: false,
        labels: {
          step: 1
        }
      )
      f.yAxis(
        title: {text: nil},
      )

      f.series({
              name: 'Value',
              data: [-2.2, -2.2, -2.3, -2.5, -2.7, -3.1, -3.2,
                  -3.0, -3.2, -4.3, -4.4, -3.6, -3.1, -2.4,
                  -2.5, -2.3, -1.2, -0.6, -0.2, -0.0, -0.0, 2, 2, 2, 3,5,6,7,4,5,6,3,4,5,3,5,
                  41, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5]
          }
      )

      f.plotOptions(
        series: {
            stacking: 'normal'
        }
      )
    end

  end
end


