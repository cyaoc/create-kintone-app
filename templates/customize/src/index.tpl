{{#if react}}
import React from 'react'
import ReactDOM from 'react-dom'
{{/if}}
{{#if vue}}
{{#if vue2}}
import Vue from 'vue'
{{else}}
import { createApp } from 'vue'
{{/if}}
import App from './App.vue'
{{else}}
import './app.css'
{{/if}}
{{#if react}}

const App = () => (
  <div className="app">
    <h1>Hello, kintone!</h1>
  </div>
)
{{/if}}

kintone.events.on('{{#if app}}app.record.index{{else if portal}}portal{{/if}}.show', (event{{#if typescript}}: KintoneEvent{{/if}}) => {
{{#if react}}
  ReactDOM.render(<App />, kintone.{{#if app}}app.getHeader{{else if portal}}portal.getContent{{/if}}SpaceElement())
{{else}}
  const myContainer = kintone.{{#if app}}app.getHeader{{else if portal}}portal.getContent{{/if}}SpaceElement(){{#if typescript}} as HTMLElement{{/if}}
  {{#if vue}}
  {{#if vue2}}
  Vue.config.productionTip = false
  new Vue({
    render: (h) => h(App),
  }).$mount(myContainer)
  {{else}}
  const app = createApp(App)
  app.mount(myContainer)
  {{/if}}
  {{else}}
  myContainer.innerHTML = '<div class="app"><h1>Hello, kintone!</h1></div>'
  {{/if}}
{{/if}}
  return event
})
