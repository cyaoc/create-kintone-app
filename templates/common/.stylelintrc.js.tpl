module.exports = {
  extends: ['stylelint-config-standard', 'stylelint-prettier/recommended'],
  ignoreFiles: ['node_modules/**/*', 'dist/**/*'{{#if plugin}}, 'src/css/51-modern-default.css'{{/if}}],
}
