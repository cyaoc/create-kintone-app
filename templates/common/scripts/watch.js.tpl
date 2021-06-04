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

const includes = (arr, file) =>
  Array.isArray(arr)
    ? arr.includes(path.basename(file, '.js')) || arr.includes(path.basename(file, '.css'))
    : arr === path.basename(file, '.js') || arr === path.basename(file, '.css')

const transform = (obj) => {
  return {
    app: obj.app,
    ignore: (file, stats) => stats.isFile() && !includes(obj.files, file),
  }
}

const getTask = (id) => {
  if (Number(id)) return { app: id, ignore }
  const object = JSON.parse(id)
  if (typeof object === 'object' && !Array.isArray(object) && Number(object.app)) return transform(object)
  throw new Error('The wrong parameter type was entered')
}

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

  const task = getTask(env[config.envAppID])
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
      await client.customizeFiles(task.app, await recursive(config.outputDir, [task.ignore]), config.customize)
      {{/if}}
    }
  })
}

watch()
