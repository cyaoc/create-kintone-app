const webpack = require('webpack')
const fs = require('fs-extra')
const configuration = require('../config/webpack.prod')
const plugin = require('./plugin')
const config = require('./config')
const logger = require('./logger')

const main = () => {
  logger.info('Start compiling.......')
  webpack(configuration, async (err, stats) => {
    if (err || stats.hasErrors()) {
      return console.error(
        err ||
          stats.toString({
            colors: true,
          }),
      )
    }
    console.log(
      stats.toString({
        colors: true,
      }),
    )
    const buffer = await plugin.pack(config.manifest, config.signature)
    fs.emptyDirSync(config.outputDir)
    fs.outputFileSync(config.output, buffer)
    return logger.info('Success to create a plugin zip!')
  })
}

main()
