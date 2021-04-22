{{#if vue}}
{{#if vue2}}
import Vue from 'vue'
{{else}}
import { createApp } from 'vue'
{{/if}}
import Config from './Config.vue'
{{else}}
{{#if react}}
import React, { useState } from 'react'
import ReactDOM from 'react-dom'
{{/if}}
import './config.css'
{{/if}}

{{#if react}}
const Config = (props{{#if typescript}}: ConfigProps{{/if}}) => {
  const { message } = props
  const [msg, setMessage] = useState(message)

  const handleSubmit = (e{{#if typescript}}: React.FormEvent{{/if}}) => {
    e.preventDefault()
    kintone.plugin.app.setConfig({ message: msg }, () => {
      window.location.href = `../../flow?app=${kintone.app.getId()}`
    })
  }

  const handleMessage = (e{{#if typescript}}: React.ChangeEvent<HTMLInputElement>{{/if}}) => {
    setMessage(e.target.value)
  }

  const handleCancel = () => {
    window.location.href = `../../${kintone.app.getId()}/plugin/`
  }

  return (
    <form className="js-submit-settings" onSubmit={handleSubmit}>
      <p className="kintoneplugin-row">
        <label htmlFor="message">
          Message:
          <input
            type="text"
            className="js-text-message kintoneplugin-input-text"
            value={msg}
            onChange={handleMessage}
          />
        </label>
      </p>
      <p className="kintoneplugin-row">
        <button type="button" className="js-cancel-button kintoneplugin-button-dialog-cancel" onClick={handleCancel}>
          Cancel
        </button>
        <button className="kintoneplugin-button-dialog-ok" type="submit">
          Save
        </button>
      </p>
    </form>
  )
}

{{/if}}
const config = kintone.plugin.app.getConfig(kintone.$PLUGIN_ID)
{{#if react}}
ReactDOM.render(<Config message={config.message} />, document.getElementById('main'))
{{else if vue}}
const main = document.getElementById('main'){{#if typescript}} as HTMLDivElement{{/if}}
{{#if vue2}}
new Vue({
  render: (h) => h(Config, { props: { msg: config.message } }),
}).$mount(main)
{{else}}
const app = createApp(Config, { msg: config.message })
app.mount(main)
{{/if}}
{{else}}
const form = document.querySelector('.js-submit-settings'){{#if typescript}} as HTMLFormElement{{/if}}
const cancelButton = document.querySelector('.js-cancel-button'){{#if typescript}} as HTMLButtonElement{{/if}}
const message = document.querySelector('.js-text-message'){{#if typescript}} as HTMLInputElement{{/if}}

if (config.message) {
  message.value = config.message
}
form.addEventListener('submit', (e) => {
  e.preventDefault()
  kintone.plugin.app.setConfig({ message: message.value }, () => {
    window.location.href = `../../flow?app=${kintone.app.getId()}`
  })
})
cancelButton.addEventListener('click', () => {
  window.location.href = `../../${kintone.app.getId()}/plugin/`
})
{{/if}}
