{{#if react}}
import React from 'react'
import ReactDOM from 'react-dom'
{{/if}}
{{#if style.css}}
import './app.css'
{{/if}}
{{#if typescript}}
interface KintoneEvent {
  record: kintone.types.SavedFields
}
{{/if}}
{{#if react}}
const App = () => {
  return (
    {{#if style.css}}
    <div className="app">
    {{else}}
    <div>
    {{/if}}
      <h1>hello, kintone!</h1>
    </div>
  )
}
{{/if}}
kintone.events.on('app.record.index.show', (event{{#if typescript}}: KintoneEvent{{/if}}) => {
{{#if react}}
  ReactDOM.render(<App />, kintone.app.getHeaderSpaceElement())
{{else}}
  const myContainer = kintone.app.getHeaderSpaceElement(){{#if typescript}} as HTMLInputElement{{/if}}
  myContainer.innerHTML = '<div{{#if style.css}} class="app"{{/if}}><h1>hello, kintone!</h1></div>'
{{/if}}
  return event
})
