const inquirer = require('inquirer')
const envfile = require('envfile')
const fs = require('fs-extra')
const config = require('./config')
const logger = require('./logger')

const validate = (err, msg) => {
  if (err) {
    logger.warn(` ${msg}`)
    return false
  }
  return true
}

const notEmpty = (input) => {
  return validate(!input || input.length === 0, 'Can not be empty')
}

const isHostname = (input) => {
  return notEmpty(input) && validate(input.toLowerCase().startsWith('https://'), 'Please do not start with https')
}

{{#if app}}
const isNumber = (input) => {
  return notEmpty(input) && validate(!/^\+?[1-9][0-9]*$/.test(input), 'Please enter a positive integer')
}

{{/if}}
const load = async (source) => {
  const questions = [
    {
      type: 'input',
      message: `Please enter hostname, such as kintone.cybozu.cn`,
      name: config.envBaseURL,
      validate: isHostname,
    },
    {
      type: 'input',
      message: `Please enter user name`,
      name: config.envUserName,
      validate: notEmpty,
    },
    {
      type: 'password',
      message: `Please enter password`,
      name: config.envPassword,
      validate: notEmpty,
    },
  {{#if app}}
    {
      type: 'input',
      message: 'Please enter appid',
      name: config.envAppID,
      validate: isNumber,
    },
  {{/if}}
  ]
  const env = fs.existsSync(source) ? envfile.parse(fs.readFileSync(source)) : {}
  for (let i = questions.length - 1; i >= 0; i -= 1) {
    if (env[questions[i].name]) questions.splice(i, 1)
  }
  if (questions.length > 0) {
    const answers = await inquirer.prompt(questions)
    Object.assign(env, answers)
    fs.outputFileSync(source, envfile.stringify(env))
  }
  return env
}

module.exports = Object.freeze({
  load,
})
