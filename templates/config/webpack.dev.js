const { merge } = require('webpack-merge')
const common = require('./webpack.common.js')
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
