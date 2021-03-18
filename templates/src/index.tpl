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
{{#if typescript}}

interface KintoneEvent {
  record: kintone.types.SavedFields
}
{{/if}}
{{#if react}}

const App = () => (
  <div className="app">
    <h1>Hello, kintone!</h1>
  </div>
)
{{/if}}

kintone.events.on('app.record.index.show', (event{{#if typescript}}: KintoneEvent{{/if}}) => {
{{#if react}}
  ReactDOM.render(<App />, kintone.app.getHeaderSpaceElement())
{{else}}
  const myContainer = kintone.app.getHeaderSpaceElement(){{#if typescript}} as HTMLInputElement{{/if}}
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
