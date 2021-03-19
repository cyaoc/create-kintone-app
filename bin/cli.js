#! /usr/bin/env node
const { program } = require('commander')
const pkg = require('../package.json')
const spawn = require('cross-spawn')
const chalk = require('chalk')
const ora = require('ora')
const os = require('os')
const inquirer = require('./inquiry.js')
const ioutil = require('./ioutil.js')
const success = chalk.greenBright
const cmd = chalk.yellow

program.version(pkg.version, '-v, --version').description(pkg.description)
program.arguments('<project-directory>').action(async (projectName) => {
  if (ioutil.validate(projectName)) {
    try {
      const project = ioutil.getRealPath(process.cwd(), projectName)
      if (project && ioutil.check(project.path, project.name)) {
        const answers = await inquirer.answers()
        const spinner = ora(`Creating a new kintone app in ${project.path}.${os.EOL}`)
        spinner.start()
        await ioutil.output(project.path, {
          name: project.name,
          ...inquirer.options(answers),
        })
        let msg = `${success(`Now you can start project with`)}
  ${cmd(`cd ${project.path}`)}
  ${cmd(`npm install`)}`
        if (answers.install) {
          const result = spawn.sync('npm', ['install'], { stdio: 'inherit', cwd: project.path })
          if (result.error) {
            throw result.error
          }
          msg = `${success(`We suggest that you begin by typing:`)}
  ${cmd(`cd ${project.path}`)}
  ${cmd(`npm start`)}`
        }
        spinner.succeed(success(`Success! Created ${project.name} at ${project.path}.`))
        spinner.info(msg)
        spinner.info(`${success(`Inside that directory, you can run several commands:`)}

  ${cmd(`npm start`)}
  Starts the development server.
  Please set ${success(`https://localhost:8080/js/app.js`)} to kintone's custom js field

  ${cmd(`npm run build`)}
  Builds optimized code under the dist directory.

  ${cmd(`npm run lint`)}
  Finds problems in your code.

  ${cmd(`npm run format`)}
  Formats the code.
`)
      }
    } catch (err) {
      console.error(err)
    }
  }
})

program.parse(process.argv)
