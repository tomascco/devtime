import { Controller } from "@hotwired/stimulus";
import * as echarts from 'echarts';
import { format, parseISO, intervalToDuration, formatDuration  } from 'date-fns'

export default class extends Controller {
  static values = {
    source: Array,
    range: String
  }

  connect() {
    const dailyTimeChart  = echarts.init(document.getElementById('dailyTimeChart'));

    dailyTimeChart.setOption({
      title: {
        text: `Total Time in ${this.rangeValue}`,
        left: 'center',
      },
      xAxis: {
        data: this.sourceValue.map((value) => format(parseISO(value[0]), 'MMM d'))
      },
      yAxis: { show: false },
      series: {
        type: 'bar',
        data: this.sourceValue.map((value) => value[1])
      },
      tooltip: {
        trigger: 'item',
        formatter: (params) => formatDuration(intervalToDuration({ start: 0, end: params.value * 1000 }))
      }
    })
  }
}
