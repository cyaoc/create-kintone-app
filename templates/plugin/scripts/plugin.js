const packFromManifest = require('@kintone/plugin-packer/from-manifest')
const fs = require('fs-extra')
const Rsa = require('node-rsa')

const gen = (ppk) => {
  if (!fs.existsSync(ppk)) {
    const key = new Rsa({ b: 1024 })
    const privateKey = key.exportKey('pkcs1-private')
    fs.outputFileSync(ppk, privateKey)
    return privateKey
  }
  return fs.readFileSync(ppk)
}

const pack = async (maifest, ppk) => {
  if (!fs.existsSync(maifest)) {
    throw new Error('Not find mainfest!')
  }
  const result = await packFromManifest(maifest, gen(ppk))
  if (!result.plugin) {
    throw new Error('Creare Plugin fail!')
  }
  return result.plugin
}

module.exports = Object.freeze({
  pack,
})
