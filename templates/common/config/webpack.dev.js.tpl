const { merge } = require('webpack-merge')
const common = require('./webpack.common.js')
{{#if plugin}}

module.exports = merge(common, {
  mode: 'development',
  devtool: 'eval-source-map',
  watch: true,
  watchOptions: {
    aggregateTimeout: 200,
    poll: 1000,
    ignored: /node_modules/,
  },
})
{{else}}
const devcert = require('devcert')
const host = 'localhost'

module.exports = async () => {
  const { key, cert } = await devcert.certificateFor(host)
  return merge(common, {
    mode: 'development',
    devtool: 'eval-source-map',
    devServer: {
      host: host,
      port: 8080,
      stats: 'errors-only',
      clientLogLevel: 'silent',
      compress: true,
      disableHostCheck: true,
      https: true,
      key,
      cert,
    },
  })
}
{{/if}}
