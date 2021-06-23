const path = require('path')
const webpack = require('../config/webpack.common')
{{#if plugin}}
const pkg = require('../package.json')
{{/if}}

const outputDir = webpack.output.path
{{#if plugin}}
const zip = `${pkg.name}.zip`
{{else}}
const outputJS = () => {
  const { entry } = webpack
  if (typeof entry === 'object' && !Array.isArray(entry)) {
    return Object.keys(entry)
  }
  return ['main']
}
{{/if}}

module.exports = Object.freeze({
  outputDir,
  envfile: path.resolve(__dirname, '../.env'),
  envBaseURL: 'BASE_URL',
  envUserName: 'USER_NAME',
  envPassword: 'PASSWORD',
  {{#if plugin}}
  signature: path.resolve(__dirname, '../private.ppk'),
  manifest: path.resolve(outputDir, 'manifest.json'),
  output: path.resolve(outputDir, zip),
  zip,
  {{else}}
  {{#if app}}
  envAppID: 'APPID',
  {{/if}}
  outputJS: outputJS(),
  domain: 'localhost',
  port: 8080,
  customize: ['desktop', 'mobile'].map((el) => el.toUpperCase()),
  {{/if}}
})
