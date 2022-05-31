import { Controller } from "@hotwired/stimulus";
import * as echarts from 'echarts';
import { formatDistance } from 'date-fns'

export default class extends Controller {
  static values = {
    source: Array
  }

  connect() {
    const dailyTimeChart  = echarts.init(document.getElementById('dailyTimeChart'));

    console.log(formatDistance(0, 2000 * 1000, { includeSeconds: true }))

    dailyTimeChart.setOption({
      title: {
        text: 'Total Time in last 7 days'
      },
      xAxis: {
        data: this.sourceValue.map((value) => value[0])
      },
      yAxis: {},
      series: {
        type: 'bar',
        data: this.sourceValue.map((value) => value[1])
      },
      tooltip: {
        // Means disable default "show/hide rule".
        trigger: 'item',
        formatter: (params) => formatDistance(0, params.value * 1000, { includeSeconds: true })
      }
    })
  }
}
