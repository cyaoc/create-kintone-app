module.exports = {
  root: true,
  {{#if vue}}
  parser: 'vue-eslint-parser',
  {{else if typescript}}
  parser: '@typescript-eslint/parser',
  {{else}}
  parser: '@babel/eslint-parser',
  {{/if}}
  env: {
    browser: true,
    es2021: true,
  },
  extends: [
    '@cybozu/eslint-config/globals/kintone',
    {{#if react}}
    'plugin:react/recommended',
    {{/if}}
    {{#if vue}}
    {{#if vue2}}
    'plugin:vue/recommended',
    {{else}}
    'plugin:vue/vue3-recommended',
    {{/if}}
    {{/if}}
    {{#if react}}
    'airbnb',
    'airbnb/hooks',
    {{else}}
    'airbnb-base',
    {{/if}}
    {{#if typescript}}
    '@cybozu/eslint-config/presets/typescript-prettier',
    'prettier/@typescript-eslint',
    {{/if}}
    {{#if react}}
    'prettier/react',
    {{/if}}
    {{#if vue}}
    'prettier/vue',
    {{/if}}
    'plugin:prettier/recommended',
  ],
  parserOptions: {
    {{#if vue}}
    {{#if typescript}}
    parser: '@typescript-eslint/parser',
    {{else}}
    parser: '@babel/eslint-parser',
    {{/if}}
    {{/if}}
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: [
    {{#if react}}
    'react',
    {{/if}}
    {{#if vue}}
    'vue',
    {{/if}}
    {{#if typescript}}
    '@typescript-eslint',
    {{/if}}
  ],
  rules: {
    {{#if react}}
    'react/jsx-filename-extension': [1, { extensions: [{{#each extensions}}'{{this}}'{{#if @last}}{{else}}, {{/if}}{{/each}}] }],
    {{#if typescript}}
    'no-use-before-define': 'off',
    '@typescript-eslint/no-use-before-define': ['error'],
    {{else}}
    'react/prop-types': 'off',
    {{/if}}
    {{/if}}
  },
};
