module.exports = {
  parser: '@babel/eslint-parser',
  extends: [
    '@cybozu/eslint-config/globals/kintone',
    {{#if react}}
    '@cybozu/eslint-config/presets/react-prettier',
    {{#if typescript}}
    '@cybozu/eslint-config/presets/react-typescript-prettier',
    {{/if}}
    {{else}}
    '@cybozu/eslint-config/presets/prettier',
    {{#if typescript}}
    '@cybozu/eslint-config/presets/typescript-prettier',
    {{/if}}
    {{/if}}
  ],
  rules: {
    {{#if react}}
    'react/jsx-filename-extension': [1, { extensions: [{{#each extensions}}'{{this}}'{{#if @last}}{{else}}, {{/if}}{{/each}}] }],
    {{/if}}
  },
}
