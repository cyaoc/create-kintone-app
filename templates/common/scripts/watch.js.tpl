const webpack = require('webpack')
const configuration = require('../config/webpack.dev')
{{#if plugin}}
const plugin = require('./plugin')
{{else}}
const recursive = require('recursive-readdir')
const path = require('path')
{{/if}}
const envfile = require('./env')
const Client = require('./client')
const config = require('./config')
const logger = require('./logger')

{{#if plugin}}
{{else}}
const ignore = (file, stats) => stats.isFile() && path.extname(file) !== '.js' && path.extname(file) !== '.css'

{{/if}}
const watch = async () => {
  logger.info('Start compiling.......')
  let hash
  const env = await envfile.load(config.envfile)
  const client = new Client(env[config.envBaseURL], env[config.envUserName], env[config.envPassword])
  {{#if plugin}}
  {{else}}

  configuration.watch = true
  configuration.watchOptions = { aggregateTimeout: 200, poll: 1000, ignored: /node_modules/ }
  {{/if}}

  webpack(configuration, async (err, stats) => {
    if (err || stats.hasErrors()) {
      console.error(
        err ||
          stats.toString({
            colors: true,
          }),
      )
    } else if (hash !== stats.hash) {
      hash = stats.hash
      console.log(
        stats.toString({
          colors: true,
        }),
      )
      {{#if plugin}}
      const buff = await plugin.pack(config.manifest, config.signature)
      await client.upload(buff, config.zip)
      {{else}}
      await client.customizeFiles({{#if app}}env[config.envAppID], {{/if}}await recursive(config.outputDir, [ignore]), config.customize)
      {{/if}}
    }
  })
}

watch()
