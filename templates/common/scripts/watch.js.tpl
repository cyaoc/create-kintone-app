const webpack = require('webpack')
const configuration = require('../config/webpack.dev')
{{#if plugin}}
const plugin = require('./plugin')
{{/if}}
const envfile = require('./env')
const Client = require('./client')
const config = require('./config')
const logger = require('./logger')

const watch = async () => {
  logger.info('Start compiling.......')
  let hash
  const env = await envfile.load(config.envfile)
  const client = new Client(env[config.envBaseURL], env[config.envUserName], env[config.envPassword])

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
      await client.customizeFiles(env[config.envAppID], config.outputDir, config.customize)
      {{/if}}
    }
  })
}

watch()
