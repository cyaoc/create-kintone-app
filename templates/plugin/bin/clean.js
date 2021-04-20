const { resolve } = require('path')
// eslint-disable-next-line import/no-extraneous-dependencies
const { removeSync } = require('fs-extra')

removeSync('dist')
removeSync(resolve('plugin', 'dist'))
