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
  path.extname(target) === '' && (target += meta.suffix)
  fs.renameSync(file, target)
}

const ignore = (options, commonDir) => {
  const set = new Set()
  if (!options.vue) {
    if (options.plugin) {
      set.add(path.join(baseTemplateDir, 'plugin', 'src', 'Desktop.vue.tpl'))
      set.add(path.join(baseTemplateDir, 'plugin', 'src', 'Config.vue.tpl'))
    } else {
      set.add(path.join(baseTemplateDir, 'app', 'src', 'App.vue.tpl'))
    }
    set.add(path.join(commonDir, 'src', 'shims-vue.d.ts'))
  }
  if (!options.typescript) {
    set
      .add(path.join(commonDir, 'tsconfig.json.tpl'))
      .add(path.join(commonDir, 'src', 'fields.d.ts.tpl'))
      .add(path.join(commonDir, 'src', 'shims-vue.d.ts'))
  }
  return set
}

const output = async (targetDir, options) => {
  const sourceDir = path.join(baseTemplateDir, options.plugin ? 'plugin' : 'app')
  const commonDir = path.join(baseTemplateDir, 'common')
  const ignoreList = ignore(options, commonDir)
  const filter = {
    filter: (source) => {
      return !(fs.lstatSync(source).isFile && ignoreList.has(source))
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
