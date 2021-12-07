const fs = require('fs')
const ncp = require('ncp')
const path = require('path')
const ejs = require('ejs')
const recursive = require('recursive-readdir')
const util = require('util')

const baseTemplateDir = path.resolve(__dirname, '../templates')

const validate = (input) => {
  if (/[\\/:*?"<>|]/im.test(input)) {
    console.error(`Cannot create a project named "${input}", please choose a different project name.`)
    return false
  }
  return true
}

const getRealPath = (base, name) => {
  const dir = path.resolve(`${base}/${name}`)
  return {
    path: dir,
    name: path.basename(dir),
  }
}

const check = (dirpath, dirname) => {
  const isExists = getStat(dirpath)
  if (isExists) {
    if (isExists.isDirectory()) {
      if (isNodeDir(dirpath)) {
        console.error(`The directory ${dirname} contains Node.js project files, please try using a new directory name.`)
        return false
      }
    } else {
      console.error(`${dirname} already exists, please try using a new directory name.`)
      return false
    }
  }
  return true
}

const getStat = (path) => {
  try {
    return fs.statSync(path)
  } catch {
    return false
  }
}

const isNodeDir = (dir) => {
  try {
    return fs.readdirSync(dir).length != 0 && fs.existsSync(path.resolve(dir, 'package.json'))
  } catch {
    return false
  }
}

const compile = async (file, options) => {
  const result = await ejs.renderFile(file, options)
  fs.writeFileSync(file, result)
  let target = file.split('.').slice(0, -1).join('.')
  path.extname(target) === '' && !path.basename(target).startsWith('.') && (target += options.suffix)
  fs.renameSync(file, target)
}

const ignore = {
  vue: ['Desktop.vue.ejs', 'Config.vue.ejs', 'App.vue.ejs'],
  ts: ['tsconfig.json.ejs', 'fields.d.ts.ejs'],
  lint: ['.eslintignore.ejs', '.eslintrc.js.ejs', '.stylelintrc.js.ejs'],
}

const getIgnorelist = (options) => {
  let arr = options.lint ? [] : ignore.lint
  if (!options.library.vue) arr = arr.concat(ignore.vue)
  if (!options.typescript) arr = arr.concat(ignore.ts)
  return new Set(arr)
}

const output = async (targetDir, options) => {
  const sourceDir = path.join(baseTemplateDir, options.type.plugin ? 'plugin' : 'customize')
  const commonDir = path.join(baseTemplateDir, 'common')
  const ignoreList = getIgnorelist(options)
  const filter = {
    filter: (source) => {
      return !(fs.lstatSync(source).isFile && ignoreList.has(path.basename(source)))
    },
  }
  const npcp = util.promisify(ncp)
  await npcp(commonDir, targetDir, filter)
  await npcp(sourceDir, targetDir, filter)
  const files = await recursive(targetDir, [
    (file, stats) => {
      return !stats.isDirectory() && path.extname(file) != '.ejs'
    },
  ])
  await Promise.all(files.map((file) => compile(file, options)))
}

module.exports = Object.freeze({
  validate,
  getRealPath,
  check,
  compile,
  output,
})
