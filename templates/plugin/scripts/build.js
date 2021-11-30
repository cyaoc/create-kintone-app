/* eslint-disable no-console */
/* eslint-disable import/no-extraneous-dependencies */
const webpack = require('webpack')
const { plugin, io } = require('kintone-dev-tools')
const path = require('path')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const pkg = require('../package.json')
const configuration = require('../config/webpack.prod')

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

const main = () => {
  webpack(configuration, async (err, stats) => {
    if (err || stats.hasErrors()) {
      console.error(
        err ||
          stats.toString({
            colors: true,
          }),
      )
      return
    }
    console.log(
      stats.toString({
        colors: true,
      }),
    )

    const manifest = path.resolve(configuration.output.path, 'manifest.json')
    plugin.saveAsSync(options.manifest, manifest, change)
    const buffer = await plugin.pack(manifest, options.ppk)
    io.outputSync(configuration.output.path, `${pkg.name}.zip`, buffer, { clean: true })
  })
}

main()
