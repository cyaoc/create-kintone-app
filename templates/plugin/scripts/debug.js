/* eslint-disable import/no-extraneous-dependencies */
const webpack = require('webpack')
const { kintone, server, plugin, io } = require('kintone-dev-tools')
const path = require('path')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const pkg = require('../package.json')
const configuration = require('../config/webpack.prod')

const envfile = path.resolve(__dirname, '.env.js')
const serverOption = {
  static: path.join(__dirname, '../dist'),
  port: 8081,
}

const options = {
  ppk: path.join(__dirname, '../private.ppk'),
  manifest: path.join(__dirname, '../src/manifest.json'),
}

const change = (value, type) => {
  if (value.startsWith('$')) {
    const key = value.slice(1)
    const output =
      type === 'js'
        ? configuration.output.filename
        : configuration.plugins[configuration.plugins.findIndex((obj) => obj instanceof MiniCssExtractPlugin)].options
            .filename
    return output.replace('[name]', key)
  }
  return value
}

const main = async () => {
  let hash

  io.emptyDirSync(serverOption.static)

  configuration.plugins.push(
    new webpack.SourceMapDevToolPlugin({
      filename: 'sourcemaps/[file].map',
      publicPath: `https://localhost${serverOption.port === 443 ? '' : `:${serverOption.port}`}/`,
      fileContext: '.',
    }),
  )
  configuration.watch = true
  configuration.watchOptions = { aggregateTimeout: 200, poll: 1000, ignored: /node_modules/ }

  const config = new kintone.Env(envfile)
  const { env } = await config.load()
  const client = new kintone.Client(env)
  server.start(serverOption)

  webpack(configuration, async (err, stats) => {
    if (err || stats.hasErrors()) {
      console.error(err || stats.toString({ colors: true }))
    } else if (hash !== stats.hash) {
      hash = stats.hash
      console.log(stats.toString({ colors: true }))

      const manifest = path.resolve(configuration.output.path, 'manifest.json')
      plugin.saveAsSync(options.manifest, manifest, change)
      const buffer = await plugin.pack(manifest, options.ppk)
      await client.uploadPlugin(`${pkg.name}.zip`, buffer)
    }
  })
}

main()
