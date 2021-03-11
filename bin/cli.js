#! /usr/bin/env node
const { program } = require('commander')
const pkg = require('../package.json')
const spawn = require('cross-spawn')
const chalk = require('chalk')
const ora = require('ora')
const os = require('os')
const inquirer = require('./inquiry.js')
const ioutil = require('./ioutil.js')
const { O_DIRECT } = require('constants')
const success = chalk.greenBright
const cmd = chalk.yellow

program.version(pkg.version, '-v, --version').description(pkg.description)
program.arguments('<project-directory>').action(async (projectName) => {
  const projectDir = `${process.cwd()}/${projectName}`
  const answers = await inquirer.answers()
  const spinner = ora(`Creating a new kintone app in ${projectDir}.${os.EOL}`)
  spinner.start()
  await ioutil.output(projectDir, {
    name: projectName,
    ...inquirer.options(answers),
  })
  let msg = `${success(`Now you can start project with`)} cd ${projectName} && npm install`
  if (answers.install) {
    const result = spawn.sync('npm', ['install'], { stdio: 'inherit', cwd: projectDir })
    if (result.error) {
      process.exit(1)
    } else {
      msg = `${success(`We suggest that you begin by typing:`)} cd ${projectName} && npm start`
    }
  }
  spinner.succeed(success(`Success! Created ${projectName} at ${projectDir}.`))
  spinner.info(msg)
  spinner.info(`${success(`Inside that directory, you can run several commands:`)}

    ${cmd(`npm start`)}
      Starts the development server.
      Please set 'https://localhost:8080/js/app.js' to kintone's custom js field

    ${cmd(`npm run build`)}
      Builds optimized code under the dist directory.

    ${cmd(`npm run lint`)}
      Finds problems in your code.

    ${cmd(`npm run format`)}
      Formats the code.

      `)
})

program.parse(process.argv)
