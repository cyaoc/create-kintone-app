const chalk = require('chalk')
const inquirer = require('inquirer')

const warn = chalk.yellowBright
//Which framework does your project use
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
    message: 'Which of the following style sheet language do you want to use?',
    name: 'css',
    choices: [
      { name: 'css', value: 1, checked: true },
      { name: 'less', value: 2 },
      { name: 'scss', value: 3 },
    ],
  },
  {
    type: 'confirm',
    message: 'Do you need to use React?',
    name: 'react',
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
    const css = Array.isArray(aws.css) && aws.css.length > 0
    let extensions = ['.js']
    const tsex = ['.ts']
    const suffix = aws.typescript && aws.react ? '.tsx' : aws.typescript ? '.ts' : '.js'
    let validate = ['javascript']
    let tsv = ['typescript']
    let js = 'js'
    let ts = 'ts'
    if (aws.react) {
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
        css,
        less: css && aws.css.includes(2),
        scss: css && aws.css.includes(3),
      },
      extensions,
      jsmatch: `/.${js}$/`,
      validate,
      suffix,
    }
  },
})
