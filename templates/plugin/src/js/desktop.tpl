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
import Desktop from './Desktop.vue'
{{else}}
import '../css/desktop.css'
{{/if}}
{{#if react}}

const Desktop = (props{{#if typescript}}: ConfigProps{{/if}}) => {
  const { message } = props
  return (
    <>
      <h3 className="plugin-space-heading">Hello kintone plugin!</h3>
      <p className="plugin-space-message">{message}</p>
    </>
  )
}
{{/if}}

const pid = kintone.$PLUGIN_ID

kintone.events.on('app.record.index.show', (event{{#if typescript}}: KintoneEvent{{/if}}) => {
  const config = kintone.plugin.app.getConfig(pid)
  const spaceElement = kintone.app.getHeaderSpaceElement(){{#if typescript}} as HTMLElement{{/if}}
{{#if react}}
  ReactDOM.render(<Desktop message={config.message} />, spaceElement)
  {{else if vue}}
  {{#if vue2}}
  new Vue({
    render: (h) => h(Desktop, { props: { msg: config.message } }),
  }).$mount(spaceElement)
  {{else}}
  const app = createApp(Desktop, { msg: config.message })
  app.mount(spaceElement)
  {{/if}}
{{else}}
  const fragment = document.createDocumentFragment()
  const headingEl = document.createElement('h3')
  const messageEl = document.createElement('p')

  messageEl.classList.add('plugin-space-message')
  messageEl.textContent = config.message
  headingEl.classList.add('plugin-space-heading')
  headingEl.textContent = 'Hello kintone plugin!'

  fragment.appendChild(headingEl)
  fragment.appendChild(messageEl)
  spaceElement.appendChild(fragment)
{{/if}}
  return event
})
