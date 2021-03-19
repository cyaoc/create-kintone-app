const chalk = require('chalk')
const inquirer = require('inquirer')

const warn = chalk.yellowBright
const questions = [
  // {
  //   type: 'list',
  //   message: 'What kind of development do you want to do?',
  //   name: 'app',
  //   choices: [
  //     { name: 'Custom App', value: 1 },
  //     { name: 'Plugin', value: 2 },
  //   ],
  //   default: 0,
  // },
  {
    type: 'author',
    message: `Please enter the author's name`,
    name: 'author',
    validate: (input) => {
      if (/[/\\]/im.test(input)) {
        console.error(` ${warn('Cannot contain special characters')}`)
        return false
      }
      return true
    },
  },
  {
    type: 'description',
    message: 'Please enter a description',
    name: 'description',
  },
  {
    type: 'checkbox',
    message: 'Which CSS Pre-processors do you want to use?',
    name: 'css',
    choices: [
      { name: 'less', value: 1 },
      { name: 'scss', value: 2 },
    ],
  },
  {
    type: 'list',
    message: 'Which Javascript library do you want to use?',
    name: 'library',
    choices: [
      { name: 'none', value: 1 },
      { name: 'React', value: 2 },
      { name: 'Vue.js', value: 3 },
    ],
    default: 0,
  },
  {
    type: 'list',
    message: 'Which version do you want to choose?',
    name: 'vue',
    choices: [
      { name: 'Vue 2.x(compatibility first)', value: 2 },
      { name: 'Vue 3.x(new features first)', value: 3 },
    ],
    when(answers) {
      return answers.library === 3
    },
    default: 0,
  },
  {
    type: 'confirm',
    message: 'Do you need to use Typescript?',
    name: 'typescript',
  },
  {
    type: 'confirm',
    message: 'Would you like to install dependencies now with npm?',
    name: 'install',
  },
]

module.exports = Object.freeze({
  answers: () => {
    return inquirer.prompt(questions)
  },
  options: (aws) => {
    const react = aws.library === 2
    const vue = aws.library === 3
    let extensions = ['.js']
    const tsex = ['.ts']
    const suffix = aws.typescript && react ? '.tsx' : aws.typescript ? '.ts' : '.js'
    let validate = ['javascript']
    let tsv = ['typescript']
    let js = 'js'
    let ts = 'ts'
    if (react) {
      extensions.unshift('.jsx')
      validate.push('javascriptreact')
      tsv.push('typescriptreact')
      js = 'jsx?'
      ts = 'tsx?'
      tsex.unshift('.tsx')
    }
    if (aws.typescript) {
      extensions = tsex.concat(extensions)
      validate = validate.concat(tsv)
      js = `(${ts}|${js})`
    }
    return {
      ...aws,
      style: {
        less: aws.css.includes(1),
        scss: aws.css.includes(2),
      },
      react,
      vue,
      vue2: vue && aws.vue === 2,
      vue3: vue && aws.vue === 3,
      extensions,
      jsmatch: `/.${js}$/`,
      validate,
      suffix,
    }
  },
})
