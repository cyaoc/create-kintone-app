const webpack = require('webpack')
const devcert = require('devcert')
const WebpackDevServer = require('webpack-dev-server')
const configuration = require('../config/webpack.dev')
const envfile = require('./env')
const Client = require('./client')
const config = require('./config')
const logger = require('./logger')

const devServer = {
  host: 'localhost',
  port: config.port,
  stats: 'errors-only',
  clientLogLevel: 'silent',
  compress: true,
  disableHostCheck: true,
  https: true,
}

const setCert = async () => {
  try {
    const { key, cert } = await devcert.certificateFor(config.domain)
    devServer.key = key
    devServer.cert = cert
    devServer.host = config.domain
    return true
  } catch (err) {
    if (err.message) logger.error(err.message)
    logger.warn('Unable to create a certificate, the server will run in non-secure certificate mode.')
    return false
  }
}

const includes = (arr, file) => (Array.isArray(arr) ? arr.includes(file) : arr === file)

const transform = (obj) => {
  if (Number(obj)) return { app: obj }
  if (!Number(obj.app)) throw new Error('The wrong parameter type was entered')
  return {
    app: obj.app,
    filter: (file) => includes(obj.files, file),
  }
}

const getTasks = (id) => {
  if (Number(id)) return [{ app: id }]
  const objects = JSON.parse(id)
  if (typeof objects === 'object') {
    if (Array.isArray(objects)) return objects.map((obj) => transform(obj))
    return [transform(objects)]
  }
  return []
}

const main = async () => {
  if (!devServer.https) throw new Error('The URL must start with "https://".')
  logger.info('Start dev server.......')
  // https://github.com/webpack/webpack-dev-server/issues/2758
  configuration.target = 'web'

  const compiler = webpack(configuration)

  const secure = await setCert()

  const env = await envfile.load(config.envfile)
  const client = new Client(env[config.envBaseURL], env[config.envUserName], env[config.envPassword])

  const tasks = getTasks(env[config.envAppID])

  const server = new WebpackDevServer(compiler, devServer)
  server.listen(devServer.port, devServer.host, () => {
    const port = devServer.port === 443 ? '' : `:${devServer.port}`
    if (!secure) {
      logger.warn('As a non-secure certificate is used, please verify before debugging.')
      logger.warn(`Please click -> https://${devServer.host}${port}/`)
    }

    Promise.all(
      tasks.map((task) =>
        client.customizeLinks(
          task.app,
          config.outputJS
            .filter((el) => (task.filter ? task.filter(el) : true))
            .map((file) => `https://${devServer.host}${port}/js/${file}.js`),
          config.customize,
        ),
      ),
    )
  })
}

main()
