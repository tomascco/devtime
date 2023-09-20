import { Controller } from "@hotwired/stimulus";
import * as echarts from "echarts";
import { fromUnixTime, format, addSeconds, getUnixTime, parseJSON, startOfDay } from "date-fns";
import { utcToZonedTime } from "date-fns-tz"

export default class extends Controller {
  static values = {
    hits: Array,
    appointments: Array,
    day: String,
    timeZone: String
  }

  connect() {
    const timelineChart =  echarts.init(document.getElementById('hits-timeline'));
    const projects = [];
    const dayStart = getUnixTime(utcToZonedTime(this.dayValue, this.timeZoneValue));

    const data = this.hitsValue.map(hit => {
      const hitTime = getUnixTime(parseJSON(hit.timestamp));
      let projectIndex = projects.findIndex(p => p === hit.project);
      if (projectIndex === -1) {
        projects.push(hit.project);
        projectIndex = projects.length - 1;
      }
      const timemark = hitTime - dayStart;

      return {
        name: hit.language,
        value: [projectIndex, timemark, timemark + 10]
      }
    });

    this.appointmentsValue.forEach(appointment => {
      const startTime = getUnixTime(parseJSON(appointment.start_time)) - dayStart;
      const endTime = getUnixTime(parseJSON(appointment.end_time)) - dayStart;
      let appointmentKindIndex = projects.findIndex(a => a === "Appointments");
      if (appointmentKindIndex === -1) {
        projects.push("Appointments");
        appointmentKindIndex = projects.length - 1;
      }

      data.push({name: appointment.name, value: [appointmentKindIndex, startTime, endTime]})
    });

    timelineChart.setOption({
      tooltip: {
        formatter: (params) => (
          params.marker + params.name + ': ' + format(addSeconds(fromUnixTime(dayStart), params.value[1]), 'HH:mm')
        )
      },
      title: {
        text: 'Profile',
        left: 'center'
      },
      dataZoom: [
        {
          type: 'slider',
          filterMode: 'weakFilter',
          showDataShadow: false,
          top: 400,
          labelFormatter: ''
        },
        {
          type: 'inside',
          filterMode: 'weakFilter'
        }
      ],
      grid: {
        height: 300,
        containLabel: true
      },
      xAxis: {
        min: 0,
        max: 60 * 60 * 24,
        scale: true,
        axisLabel: {
          formatter: (val) => (
            format(addSeconds(fromUnixTime(dayStart), val), 'HH:mm')
          )
        }
      },
      yAxis: {
        data: projects
      },
      series: [
        {
          type: 'custom',
          renderItem: this.renderItem,
          itemStyle: {
            opacity: 0.8
          },
          encode: {
            x: [1, 2],
            y: 0
          },
          data: data
        }
      ]
    })
  }

  renderItem(params, api) {
    var categoryIndex = api.value(0);
    var start = api.coord([api.value(1), categoryIndex]);
    var end = api.coord([api.value(2), categoryIndex]);
    var height = api.size([0, 1])[1] * 0.6;
    var rectShape = echarts.graphic.clipRectByRect(
      {
        x: start[0],
        y: start[1] - height / 2,
        width: end[0] - start[0],
        height: height
      },
      {
        x: params.coordSys.x,
        y: params.coordSys.y,
        width: params.coordSys.width,
        height: params.coordSys.height
      }
    );
    return (
      rectShape && {
        type: 'rect',
        transition: ['shape'],
        shape: rectShape,
        style: api.style()
      }
    );
  }
};
