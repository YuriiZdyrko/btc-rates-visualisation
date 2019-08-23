<template>
<div id="app">
  <!-- <router-view></router-view> -->
  <ul class="DurationPicker">
    <li>
      <label for="duration-day">Past Minute</label>
      <input id="duration-day" type="radio" name="duration" v-model="duration" value="1min" @change="triggerRebuild" />
    </li>
    <li>
      <label for="duration-hour">Past Hour</label>
      <input id="duration-hour" type="radio" name="duration" v-model="duration" value="1hr" @change="triggerRebuild" />
    </li>
    <li>
      <label for="duration-24">Past 24 Hours</label>
      <input id="duration-24" type="radio" name="duration" v-model="duration" value="24hr" @change="triggerRebuild" />
    </li>
  </ul>

  <pulse-loader class="Loader" :loading="isLoading"></pulse-loader>
  <GChart type="LineChart" :data="chartData" :options="CHART_OPTIONS" />
</div>
</template>

<script>
import moment from 'moment'
import PulseLoader from 'vue-spinner/src/PulseLoader.vue'

export default {
  name: 'app',
  components: {
    PulseLoader
  },
  data: function() {
    const till = moment()

    return {
      unit: 'second',
      isLoading: null,
      duration: '1min',
      REFRESH_RATE: 3000,
      chartData: null,
      CHART_OPTIONS: {
        height: 600,
        curveType: 'function',
        hAxis: {
          format: 'hh:mm:ss',
          gridlines: {
            count: 15
          }
        },
        vAxis: {
          gridlines: {
            color: 'none'
          },
          minValue: 0,
          scaleType: 'log'
        }
      }
    }
  },
  created: function() {
    this.triggerRebuild()
  },
  beforeDestroy() {
    clearTimeout(this.timeout)
  },
  methods: {
    triggerRebuild: function() {
      clearTimeout(this.timeout)
      const till = moment()
      this.till = till.clone()
      switch (this.duration) {
        case '1min':
          this.unit = 'second'
          this.since = till.clone().subtract(1, 'minutes')
          break;
        case '1hr':
          this.unit = 'minute'
          this.since = till.clone().subtract(1, 'hours')
          break;
        case '24hr':
          this.unit = 'hour'
          this.since = till.clone().subtract(24, 'hours')
          break;
      }
      this.rebuild()
    },
    rebuild: function() {
      this.isLoading = true

      this.fetchChartData()
        .then(response => {
          this.chartData = this.prepareChartData(response)
          console.info('Applying new chartData:')
          console.info(this.chartData)
        }, response => {
          console.error('Chart data failed to load');
          console.error(response)
        })
        .finally(() => {
          this.timeout = setTimeout(() => {
            this.triggerRebuild()
          }, this.REFRESH_RATE);
          this.isLoading = false
        });
    },
    fetchChartData: function() {
      return this.$http.get('/api/rates', {
        params: {
          unit: this.unit,
          since: this.since.toISOString(),
          till: this.till.toISOString()
        }
      })
    },
    prepareChartData: function(response) {
      const prices = response.body.prices.map(([date, ...prices]) => {
        return [
          new Date(date),
          ...prices.map(price => price && parseFloat(price))
        ]
      })

      return [
        ['Date', ...response.body.currencies],
        ...prices
      ]
    }
  }
}
</script>

<style scoped>
.DurationPicker {
  list-style-type: none;
  margin: 0;
}

.DurationPicker li {
  display: inline-block;
  margin-right: 20px;
}

.Loader {
  position: fixed;
  z-index: 100;
  top: 5px;
  right: 40px;
}
</style>
