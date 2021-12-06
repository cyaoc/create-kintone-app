const chalk = require('chalk')
const inquirer = require('inquirer')

const warn = chalk.yellowBright
const questions = [
  {
    type: 'list',
    message: 'What kind of development do you want to do?',
    name: 'type',
    choices: [
      { name: 'Custom App', value: 1 },
      { name: 'Plugin', value: 2 },
      { name: 'Portal', value: 3 },
    ],
    default: 0,
  },
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
      { name: 'Vue 2.x', value: 2 },
      { name: 'Vue 3.x', value: 3 },
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
    message: 'Do you need to use eslint and stylint to catch probable bugs?',
    name: 'lint',
  },
  {
    type: 'confirm',
    message: 'Would you like to install dependencies now with yarn?',
    name: 'install',
  },
]

module.exports = Object.freeze({
  answers: () => {
    return inquirer.prompt(questions)
  },
  options: (aws) => {
    const options = {
      type: {
        app: aws.type === 1,
        plugin: aws.type === 2,
        portal: aws.type === 3,
      },
      author: aws.author,
      description: aws.description,
      style: {
        less: aws.css.includes(1),
        scss: aws.css.includes(2),
      },
      library: {
        react: aws.library === 2,
      },
      typescript: aws.typescript,
      lint: aws.lint,
      install: aws.install,
      extensions: ['.js'],
      styleEx: ['css'],
    }
    if (aws.library === 3) options.library.vue = aws.vue
    options.suffix = options.typescript && options.library.react ? '.tsx' : options.typescript ? '.ts' : '.js'
    const tsex = ['.ts']
    if (options.library.react) {
      options.extensions.unshift('.jsx')
      tsex.unshift('.tsx')
    }
    if (options.typescript) options.extensions = tsex.concat(options.extensions)
    if (options.style.less) options.styleEx.push('less')
    if (options.style.scss) options.styleEx.push('scss')
    if (options.library.vue) options.styleEx.push('vue')
    return options
  },
})
