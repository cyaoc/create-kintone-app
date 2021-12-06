/* eslint-disable import/no-extraneous-dependencies */
const packFromManifest = require('@kintone/plugin-packer/from-manifest')
const webpack = require('webpack')
const WebpackDevServer = require('webpack-dev-server')
const { cert, plugin, io, kintone } = require('kintone-dev-tools')
const path = require('path')
const configuration = require('../config/webpack.dev')
const pkg = require('../package.json')

const envfile = path.resolve(__dirname, '.env.js')

const options = {
  ppk: path.join(__dirname, '../private.ppk'),
  manifest: path.join(__dirname, '../src/manifest.json'),
}

const devServer = {
  host: 'localhost',
  port: 8080,
  hot: false,
  liveReload: true,
  allowedHosts: 'all',
  compress: true,
  static: {
    directory: path.join(__dirname, '../src'),
  },
}

const main = async () => {
  const config = new kintone.Env(envfile)
  const { env } = await config.load()
  const client = new kintone.Client(env)
  io.emptyDirSync(configuration.output.path)

  const compiler = webpack(configuration)
  const tls = cert.certificateFor()
  devServer.server = {
    type: 'https',
    options: {
      key: tls.private,
      cert: tls.cert,
    },
  }
  const port = devServer.port === 443 ? '' : `:${devServer.port}`
  const baseurl = `https://${devServer.host}${port}`
  devServer.client = { webSocketURL: `${baseurl}/ws` }

  const server = new WebpackDevServer(devServer, compiler)
  await server.start()

  const url = new URL(configuration.output.filename, baseurl).href

  const change = (value, type) => {
    if (value.startsWith('$')) {
      const key = value.slice(1)
      if (type === 'css') return undefined
      return url.replace('[name]', key)
    } else if (!value.startsWith('https://')) {
      return `${baseurl}/${value}`
    }
    return value
  }

  const manifest = path.resolve(configuration.output.path, 'manifest.json')
  const data = plugin.saveAsSync(options.manifest, manifest, change)
  plugin.copyNecessarySync(options.manifest, configuration.output.path, data)
  const buffer = await plugin.pack(manifest, options.ppk)

  await client.uploadPlugin(`${pkg.name}.zip`, buffer)
}

main()
