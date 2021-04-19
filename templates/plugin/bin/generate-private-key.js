const { writeFileSync, existsSync } = require('fs')
const { resolve } = require('path')
// eslint-disable-next-line import/no-extraneous-dependencies
const NodeRSA = require('node-rsa')

const path = resolve('plugin', 'private.ppk')

if (!existsSync(path)) {
  const key = new NodeRSA({ b: 1024 })
  const privateKey = key.exportKey('pkcs1-private')
  writeFileSync(path, privateKey)
}
