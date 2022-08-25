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
    this.buildLanguagesPieChart();
  }

  buildDailyTimeChart() {
    const dailyTimeChart  = echarts.init(document.getElementById('dailyTimeChart'));

    const totalTimeByProject = {};
    this.dailyValue.forEach(day => {
      Object.entries(day[2]).forEach(([key]) => {
        totalTimeByProject[key] = Array(this.dailyValue.length).fill(null);
      })
    });
    this.dailyValue.forEach((day, index) => {
      Object.entries(day[2]).forEach(([key, value]) => {
        totalTimeByProject[key][index] = value;
      })
    });

    dailyTimeChart.setOption({
      title: {
        text: `Total Time in ${this.rangeValue}`,
        left: 'center',
      },
      xAxis: {
        data: this.dailyValue.map((value) => format(parseISO(value[0]), 'MMM d'))
      },
      yAxis: { show: false },
      series: [
        {
          name: 'total',
          type: 'line',
          data: this.dailyValue.map((value) => value[1]),
          tooltip: {
            valueFormatter: (value) => value && this.formatDuration(value)
          }
        },
        ...Object.entries(totalTimeByProject).map(([key, value]) => ({
          type: 'bar',
          name: key,
          stack: 'total',
          data: value,
          emphasis: {
            focus: 'series'
          },
          areaStyle: {},
          tooltip: {
            valueFormatter: (value) => value && this.formatDuration(value)
          },
          connectNulls: false
        }))
      ],
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'cross',
          label: {
            backgroundColor: '#6a7985'
          }
        },
      },

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

  buildLanguagesPieChart() {
    const data = {};
    this.dailyValue.forEach(day => {
      const languages = day[3];
      if (!languages) return;
      Object.entries(languages).forEach(([key, value]) => {
        data[key] = (data[key] || 0) + value;
      })
    });
    const dataArray =  Object.entries(data).map(([key, value]) => ({ name: key, value }));
    const languagesPieChart  = echarts.init(document.getElementById('languagesPieChart'));

    languagesPieChart.setOption({
      title: {
        text: 'Total by language in period',
        left: 'center',
        top: '0'
      },
      tooltip: {
        trigger: 'item',
        formatter: (params) => `${params.data.name} <br/> ${this.formatDuration(params.value)} (${params.percent}%)`
      },
      legend: {
        orient: 'vertical',
        top: '10%',
        right: '10%',
        type: 'scroll',
      },
      series: [
        {
          name: 'Language',
          type: 'pie',
          radius: ['40%', '70%'],
          center: ['30%', '50%'],
          avoidLabelOverlap: false,
          itemStyle: {
            borderRadius: 10,
            borderColor: '#fff',
            borderWidth: 2
          },
          label: {
            show: false,
            position: 'center'
          },
          emphasis: {
            label: {
              show: true,
              fontSize: '30',
              fontWeight: 'bold'
            }
          },
          labelLine: {
            show: false
          },
          data: dataArray
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
