$ ->

  data = [[0.1,0.003], [0.2,0.005], [0.3,0.008],[0.4,0.003], [0.5,0.005], [0.6,0.008]]
  $("#container1").highcharts "StockChart",
    rangeSelector:
      selected: 1

    title:
      text: "AAPL Stock Price"

    
    xAxis: {
      allowDecimals: false

      dateTimeLabelFormats : {
        millisecond: '%S.%L'
        second: '%S.%L',
        minute: '%S.%L',
        hour: '%S.%L',
        day: '%S.%L',
        week: '%S.%L',
        month: '%S.%L',
        year: '%S.%L'
      }
    }

    navigator: {
      xAxis: {
        dateTimeLabelFormats: false
      }
    },

    tooltip: {
      dateTimeLabelFormats: {
        millisecond: '%S.%L'
        second: '%S.%L',
        minute: '%S.%L',
        hour: '%S.%L',
        day: '%S.%L',
        week: '%S.%L',
        month: '%S.%L',
        year: '%S.%L'
      }
    },


    rangeSelector: {
        buttons: [{
            count: 0.1,
            type: 'minute',
            text: '1M'
        }, {
            count: 0.5,
            type: 'minute',
            text: '5M'
        }, {
            type: 'all',
            text: 'All'
        }],
        inputEnabled: false,
        selected: 0
    }



    series: [
      name: "AAPL"
      data: data
      tooltip:
        valueDecimals: 2
    ]
  
