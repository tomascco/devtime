import { Controller } from "@hotwired/stimulus";
import * as echarts from 'echarts';
import { format, parseISO, intervalToDuration, formatDuration } from 'date-fns'

export default class extends Controller {
  static values = {
    daily: Array,
    range: String,
    todayTotal: Number,
    yesterdayTotal: Number,
    periodTotal: Number
  }

  connect() {
    this.buildDailyTimeChart();
    this.buildTotalsChart();
  }

  buildDailyTimeChart() {
    const dailyTimeChart  = echarts.init(document.getElementById('dailyTimeChart'));

    dailyTimeChart.setOption({
      title: {
        text: `Total Time in ${this.rangeValue}`,
        left: 'center',
      },
      xAxis: {
        data: this.dailyValue.map((value) => format(parseISO(value[0]), 'MMM d'))
      },
      yAxis: { show: false },
      series: {
        type: 'bar',
        data: this.dailyValue.map((value) => value[1])
      },
      tooltip: {
        trigger: 'item',
        formatter: (params) => formatDuration(intervalToDuration({ start: 0, end: params.value * 1000 }))
      }
    })
  }

  buildTotalsChart() {
    const totalsChart = echarts.init(document.getElementById('totalsChart'));
    totalsChart.setOption({
      title: {
        text: 'Total Times',
        left: 'center',
      },
      series: [
        {
          type: 'gauge',
          startAngle: 180,
          endAngle: 0,
          max: Math.max(this.todayTotalValue, this.yesterdayTotalValue, this.periodTotalValue) + 1000,
          pointer: { show: false },
          progress: {
            show: true,
            overlap: false,
            roundCap: true,
            clip: false,
            itemStyle: {
              borderWidth: 1,
              borderColor: '#464646'
            }
          },
          axisLine: {
            lineStyle: { width: 40, color: [[1, 'white']] },
          },
          splitLine: { show: false },
          axisTick: { show: false },
          axisLabel: { show: false },
          title: { fontSize: 14 },
          detail: {
            width: 50,
            height: 14,
            fontSize: 13,
            color: 'inherit',
            formatter: this.formatDuration,
          },
          data: [
            {
              name: 'Today',
              value: this.todayTotalValue,
              title: {
                offsetCenter: ['0%', '-50%']
              },
              detail: {
                valueAnimation: true,
                offsetCenter: ['0%', '-40%']
              },
            },
            {
              name: 'Yesterday',
              value: this.yesterdayTotalValue,
              title: {
                offsetCenter: ['0%', '-20%']
              },
              detail: {
                valueAnimation: true,
                offsetCenter: ['0%', '-10%']
              }
            },
            {
              name: 'Mean in Period',
              value: this.periodTotalValue,
              title: {
                offsetCenter: ['0%', '10%']
              },
              detail: {
                valueAnimation: true,
                offsetCenter: ['0%', '20%']
              }
            },

          ]
        }
      ]
    })
  }

  formatDuration(duration) {
    return formatDuration(intervalToDuration({ start: 0, end: duration * 1000 }))
      .replace(/hour[s]*/, 'h')
      .replace(/minute[s]*/, 'm')
      .replace(/second[s]*/, 's')
  }
};
