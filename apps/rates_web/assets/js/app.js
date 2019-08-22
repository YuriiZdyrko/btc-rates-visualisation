// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

import App from './App.vue'

import Vue from 'vue'
import VueResource from 'vue-resource'
import VueGoogleCharts from 'vue-google-charts'

Vue.use(VueResource)
Vue.use(VueGoogleCharts)
Vue.component('app', App)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  render: h => h(App),
  components: { App }
})
