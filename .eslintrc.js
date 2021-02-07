module.exports = {
  env: {
    commonjs: true,
    es2021: true,
    node: true,
  },
  extends: ['airbnb-base', 'prettier', 'prettier/@typescript-eslint', 'prettier/react', 'prettier/unicorn'],
  parserOptions: {
    ecmaVersion: 12,
  },
  rules: {},
}
