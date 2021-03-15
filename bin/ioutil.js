const fs = require('fs')
const ncp = require('ncp')
const path = require('path')
const handlebars = require('handlebars')
const util = require('util')
const templateDir = path.resolve(__dirname, '../templates')

const check = (dirpath, dirname) => {
  if (/[\\/:*?"<>|]/im.test(dirname)) {
    console.error(`Cannot create a project named "${dirname}", please choose a different project name.`)
    return false
  }
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

const compile = (meta, file, dir) => {
  const content = fs.readFileSync(file).toString()
  const result = handlebars.compile(content)(meta)
  let target = file.replace(templateDir, dir).split('.').slice(0, -1).join('.')
  if (file === path.join(templateDir, 'src', 'index.tpl')) {
    target += meta.suffix
  }
  fs.writeFileSync(target, result)
}

const ignore = (options) => {
  const set = new Set()
  if (options.vue) {
    set.add(path.join(templateDir, 'src', 'app.css'))
  } else {
    set.add(path.join(templateDir, 'src', 'App.vue'))
    set.add(path.join(templateDir, 'src', 'shims-vue.d.ts'))
  }
  if (!options.typescript) {
    set
      .add(path.join(templateDir, 'tsconfig.json.tpl'))
      .add(path.join(templateDir, 'src', 'fields.d.ts'))
      .add(path.join(templateDir, 'src', 'shims-vue.d.ts'))
  } else {
    set.add(path.join(templateDir, 'jsconfig.json'))
  }
  return set
}

const output = (filePath, options) => {
  const ignoreList = ignore(options)
  const filter = {
    filter: (source) => {
      if (!fs.lstatSync(source).isDirectory()) {
        if (ignoreList.has(source)) {
          return false
        }
        if (path.extname(source) === '.tpl') {
          compile(options, source, filePath)
          return false
        }
      }
      return true
    },
  }
  const npcp = util.promisify(ncp)
  return npcp(templateDir, filePath, filter)
}

module.exports = Object.freeze({
  check,
  compile,
  output,
})
