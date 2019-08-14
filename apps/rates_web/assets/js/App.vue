<template>
  <div id="app">
    <!-- <router-view></router-view> -->
    <ul class="DurationPicker">
      <li>
        <label for="duration-day">Past Minute</label>
        <input
          id="duration-day"
          type="radio"
          name="duration"
          v-model="duration"
          value="60"
          @change="handleDurationChange"
        />
      </li>
      <li>
        <label for="duration-hour">Past Hour</label>
        <input
          id="duration-hour"
          type="radio"
          name="duration"
          v-model="duration"
          value="3600"
          @change="handleDurationChange"
        />
      </li>
      <li>
        <label for="duration-24">Past 24 Hours</label>
        <input
          id="duration-24"
          type="radio"
          name="duration"
          v-model="duration"
          value="86400"
          @change="handleDurationChange"
        />
      </li>
    </ul>

    <pulse-loader :loading="isLoading"></pulse-loader>
    <div>
      <GChart
        type="LineChart"
        :data="chartData"
        :options="chartOptions"
      />
    </div>
  </div>
</template>

<script>
const REFRESH_RATE = 100000 // msec
import PulseLoader from 'vue-spinner/src/PulseLoader.vue'

export default {
  name: 'app',
  components: {
    PulseLoader
  },
  data: function () {
    return {
      isLoading: null,
      duration: 60,
      unit: 'second',
      chartData: null,
      chartOptions: {
        height: 800,
        curveType: 'function',
        hAxis: {
          format: 'hh:mm:ss',
          gridlines: {count: 15}
        },
        vAxis: {
          gridlines: {color: 'none'},
          minValue: 0,
          scaleType: 'log'
        }
      }
    }
  },
  created: function () {
    this.rebuildChart()
  },
  beforeDestroy () {
    clearTimeout(this.timeout)
  },
  methods: {
    rebuildChart: function() {
      this.isLoading = true
      this.fetch()
        .then(response => {
          const prices = this.preparePrices(response.body.prices)

          this.chartData = [
            ['Date', ...response.body.currencies],
            ...prices
          ]

          console.info('Applying new chartData:')
          console.info(this.chartData)

          this.timeout = setTimeout(() => {
            this.rebuildChart()
          }, REFRESH_RATE);
        }, response => {
          alert('chart data failed to load');
        })
        .finally(() => {
          this.isLoading = false
        });
    },
    fetch: function() {
      return this.$http.get('/api/rates', {params: {duration: this.duration, unit: this.unit}})
    },
    preparePrices: function(prices) {
      return prices.map(([date, ...prices]) => {
        return [
          new Date(date),
          ...prices.map(price => price && parseFloat(price))
        ]
      })
    },
    handleDurationChange: function() {
      clearTimeout(this.timeout)
      switch (this.duration) {
        case '60':
          this.unit = 'second';
          break;
        case '3600':
          this.unit = 'minute';
          break;
        case '86400':
          this.unit = 'hour';
          break;
      }
      this.rebuildChart()
    }
  }
}
</script>

<style scoped>
.DurationPicker {
  list-style-type: none;
}
.DurationPicker li {
  display: inline-block;
  margin-right: 20px;
}

.lds-heart {
  display: inline-block;
  position: relative;
  width: 64px;
  height: 64px;
  transform: rotate(45deg);
  transform-origin: 32px 32px;
}
.lds-heart div {
  top: 23px;
  left: 19px;
  position: absolute;
  width: 26px;
  height: 26px;
  background: #fff;
  animation: lds-heart 1.2s infinite cubic-bezier(0.215, 0.61, 0.355, 1);
}
.lds-heart div:after,
.lds-heart div:before {
  content: " ";
  position: absolute;
  display: block;
  width: 26px;
  height: 26px;
  background: #fff;
}
.lds-heart div:before {
  left: -17px;
  border-radius: 50% 0 0 50%;
}
.lds-heart div:after {
  top: -17px;
  border-radius: 50% 50% 0 0;
}
@keyframes lds-heart {
  0% {
    transform: scale(0.95);
  }
  5% {
    transform: scale(1.1);
  }
  39% {
    transform: scale(0.85);
  }
  45% {
    transform: scale(1);
  }
  60% {
    transform: scale(0.95);
  }
  100% {
    transform: scale(0.9);
  }
}

</style>
