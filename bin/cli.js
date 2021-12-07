#! /usr/bin/env node
const { program } = require('commander')
const pkg = require('../package.json')
const spawn = require('cross-spawn')
const chalk = require('chalk')
const ora = require('ora')
const os = require('os')
const inquirer = require('./inquiry')
const ioutil = require('./ioutil')
const success = chalk.greenBright
const cmd = chalk.yellowBright

program.version(pkg.version, '-v, --version').description(pkg.description)
program.arguments('<project-directory>').action(async (projectName) => {
  if (ioutil.validate(projectName)) {
    const project = ioutil.getRealPath(process.cwd(), projectName)
    if (project && ioutil.check(project.path, project.name)) {
      const answers = await inquirer.answers()
      const spinner = ora(`Creating a new kintone app in ${project.path}.${os.EOL}`)
      spinner.start()
      const onptions = inquirer.options(answers)
      await ioutil.output(project.path, {
        name: project.name,
        ...onptions,
      })
      let msg = `${success(`Now you can start project with`)}
  ${cmd(`cd ${project.path}`)}
  ${cmd(`npm install`)}`
      if (onptions.install) {
        const result = spawn.sync('npm', ['install'], { stdio: 'inherit', cwd: project.path })
        if (result.error) throw result.error

        msg = `${success(`We suggest that you begin by typing:`)}
  ${cmd(`cd ${project.path}`)}
  ${cmd(`npm start`)}`
      }
      spinner.succeed(success(`Success! Created ${project.name} at ${project.path}.`))
      spinner.info(msg)

      const cmd_start = `
  ${cmd(`npm start`)}
  ${
    onptions.plugin
      ? 'Turns on watch mode, automatically package and upload'
      : 'Uploads the js file and starts the development server.'
  }`
      spinner.info(`${success(`Inside that directory, you can run several commands:`)}
  ${cmd_start}

  ${cmd(`npm run debug`)}
  Provide sourcemap support for compiled code.

  ${cmd(`npm run build`)}
  Builds optimized code under the dist directory.
${
  onptions.lint
    ? `
  ${cmd(`npm run lint`)}
  Finds problems in your code.
  `
    : ``
}
  ${cmd(`npm run format`)}
  Formats the code.
`)
    }
  }
})

program.parse(process.argv)
