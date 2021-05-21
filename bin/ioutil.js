const fs = require('fs')
const ncp = require('ncp')
const path = require('path')
const handlebars = require('handlebars')
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
      if (!isEmptyDir(dirpath)) {
        console.error(`The directory ${dirname} contains files, please try using a new directory name.`)
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

const isEmptyDir = (path) => {
  try {
    return fs.readdirSync(path).length === 0
  } catch {
    return false
  }
}

const compile = (meta, file) => {
  const content = fs.readFileSync(file).toString()
  const result = handlebars.compile(content)(meta)
  fs.writeFileSync(file, result)
  let target = file.split('.').slice(0, -1).join('.')
  path.extname(target) === '' && !path.basename(target).startsWith('.') && (target += meta.suffix)
  fs.renameSync(file, target)
}

const ignore = {
  vue: ['Desktop.vue.tpl', 'Config.vue.tpl', 'App.vue.tpl', 'shims-vue.d.ts'],
  ts: ['tsconfig.json.tpl', 'fields.d.ts.tpl', 'shims-vue.d.ts'],
  lint: ['.eslintignore.tpl', '.eslintrc.js.tpl', '.stylelintrc.js.tpl'],
}

const getIgnorelist = (options) => {
  let arr = options.lint ? [] : ignore.lint
  if (!options.vue) arr = arr.concat(ignore.vue)
  if (!options.typescript) arr = arr.concat(ignore.ts)
  return new Set(arr)
}

const output = async (targetDir, options) => {
  const sourceDir = path.join(baseTemplateDir, options.plugin ? 'plugin' : 'app')
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
      return !stats.isDirectory() && path.extname(file) != '.tpl'
    },
  ])
  files.forEach((file) => {
    compile(options, file)
  })
}

module.exports = Object.freeze({
  validate,
  getRealPath,
  check,
  compile,
  output,
})
