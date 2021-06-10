{
  "name": "{{name}}",
  "version": "1.0.0",
  "description": "{{description}}",
  "scripts": {
    "format": "prettier --write src",
    {{#if lint}}
    "lint": "eslint --fix -c .eslintrc.js --ignore-path .eslintignore --ext {{#each extensions}}{{this}}{{#if @last}}{{else}},{{/if}}{{/each}}{{#if vue}},.vue{{/if}} src && stylelint --config .stylelintrc.js src/**/*.{{#if style.less}}{css,less{{else if style.scss}}{css{{else}}{{#if vue}}{css,vue}{{else}}css{{/if}}{{/if}}{{#if style.scss}},scss{{#if vue}},vue{{/if~}}}{{else if style.less}}{{#if vue}},vue{{/if~}}}{{/if}}",
    {{/if}}
    "start": "cross-env NODE_ENV=development node ./scripts/{{#if plugin}}watch.js{{else}}server.js{{/if}}",
    "build": "cross-env NODE_ENV=production {{#if plugin}}node ./scripts/build.js{{else}}webpack --config ./config/webpack.prod.js{{/if}}"
  },
  "keywords": [
    "kintone"
  ],
  "author": "{{author}}",
  "license": "ISC",
  "browserslist": ">0.2%, not dead, ie >= 11, not op_mini all",
  "devDependencies": {
    {{#if plugin}}
    "copy-webpack-plugin": "^9.0.0",
    "node-rsa": "^1.1.1",
    "@kintone/plugin-packer": "^5.0.4",
    {{else}}
    "devcert": "^1.1.3",
    "recursive-readdir": "^2.2.2",
    "style-loader": "^2.0.0",
    "webpack-dev-server": "^3.11.2",
    {{/if}}
    {{#if react}}
    "@babel/preset-react": "^7.13.13",
    {{#if lint}}
    "eslint-plugin-jsx-a11y": "^6.4.1",
    "eslint-plugin-react": "^7.24.0",
    "eslint-plugin-react-hooks": "^4.2.0",
    {{/if}}
    {{/if}}
    {{#if typescript}}
    "@babel/preset-typescript": "^7.13.0",
    "@kintone/dts-gen": "^4.2.2",
    "fork-ts-checker-webpack-plugin": "^6.2.10",
    "typescript": "^4.3.2",
    {{#if lint}}
    "@typescript-eslint/eslint-plugin": "^4.26.1",
    "@typescript-eslint/parser": "^4.26.1",
    {{/if}}
    {{#if react}}
    "@types/react": "^17.0.9",
    "@types/react-dom": "^17.0.6",
    {{/if}}
    {{else}}
    {{#if lint}}
    "@babel/eslint-parser": "^7.14.4",
    {{/if}}
    {{/if}}
    {{#if vue}}
    {{#if typescript}}
    "ts-loader": "^9.2.3",
    {{/if}}
    {{#if vue2}}
    "vue-loader": "^15.9.7",
    "vue-template-compiler": "^2.6.14",
    {{else}}
    "@vue/compiler-sfc": "^3.1.1",
    "vue-loader": "^16.2.0",
    {{/if}}
    {{#if lint}}
    "eslint-plugin-vue": "^7.10.0",
    "vue-eslint-parser": "^7.6.0",
    {{/if}}
    {{/if}}
    "@babel/core": "^7.14.3",
    "@babel/plugin-proposal-class-properties": "^7.13.0",
    "@babel/plugin-transform-runtime": "^7.14.3",
    "@babel/preset-env": "^7.14.4",
    {{#if lint}}
    "@cybozu/eslint-config": "^14.0.0",
    "eslint": "^7.28.0",
    "eslint-config-airbnb": "^18.2.1",
    "eslint-config-prettier": "^8.3.0",
    "eslint-plugin-import": "^2.23.4",
    "eslint-plugin-prettier": "^3.4.0",
    "stylelint": "^13.13.1",
    "stylelint-config-prettier": "^8.0.2",
    "stylelint-config-rational-order": "^0.1.2",
    "stylelint-config-standard": "^22.0.0",
    "stylelint-declaration-block-no-ignored-properties": "^2.3.0",
    "stylelint-order": "^4.1.0",
    "stylelint-prettier": "^1.2.0",
    {{/if}}
    "axios": "^0.21.1",
    "babel-loader": "^8.2.2",
    "chalk": "^4.1.1",
    "cross-env": "^7.0.3",
    "envfile": "^6.14.0",
    "form-data": "^4.0.0",
    "fs-extra": "^10.0.0",
    "inquirer": "^8.1.0",
    "prettier": "^2.3.1",
    "css-loader": "^5.2.6",
    "css-minimizer-webpack-plugin": "^3.0.1",
    "mini-css-extract-plugin": "^1.6.0",
    "postcss": "^8.3.0",
    "postcss-flexbugs-fixes": "^5.0.2",
    "postcss-loader": "^5.3.0",
    "postcss-normalize": "^10.0.0",
    "postcss-preset-env": "^6.7.0",
    {{#with style}}
    {{#if less}}
    "less": "^4.1.1",
    "less-loader": "^9.0.0",
    {{/if}}
    {{#if scss}}
    "node-sass": "^{{#if sass6}}6{{else}}5{{/if}}.0.0",
    "sass-loader": "^12.0.0",
    {{/if}}
    {{/with}}
    "terser-webpack-plugin": "^5.1.3",
    "webpack": "^5.38.1",
    "webpack-cli": "^4.7.2",
    "webpack-merge": "^5.8.0"
  },
  "dependencies": {
    {{#if react}}
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    {{/if}}
    {{#if vue}}
    "vue": "^{{#if vue2}}2.6.14{{else}}3.1.1{{/if}}",
    {{/if}}
    "@babel/runtime-corejs3": "^7.14.0"
  }
}
