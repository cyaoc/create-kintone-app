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
    "copy-webpack-plugin": "^8.1.1",
    "node-rsa": "^1.1.1",
    "@kintone/plugin-packer": "^4.0.3",
    {{else}}
    "devcert": "^1.1.3",
    "recursive-readdir": "^2.2.2",
    "style-loader": "^2.0.0",
    "webpack-dev-server": "^3.11.1",
    {{/if}}
    {{#if react}}
    "@babel/preset-react": "^7.12.10",
    {{#if lint}}
    "eslint-plugin-jsx-a11y": "^6.4.1",
    "eslint-plugin-react": "^7.22.0",
    "eslint-plugin-react-hooks": "^4.2.0",
    {{/if}}
    {{/if}}
    {{#if typescript}}
    "@babel/preset-typescript": "^7.12.7",
    "@kintone/dts-gen": "^3.1.0",
    "fork-ts-checker-webpack-plugin": "^6.1.0",
    "typescript": "^4.1.3",
    {{#if lint}}
    "@typescript-eslint/eslint-plugin": "^4.16.1",
    "@typescript-eslint/parser": "^4.16.1",
    {{/if}}
    {{#if react}}
    "@types/react": "^17.0.0",
    "@types/react-dom": "^17.0.0",
    {{/if}}
    {{else}}
    {{#if lint}}
    "@babel/eslint-parser": "^7.12.1",
    {{/if}}
    {{/if}}
    {{#if vue}}
    {{#if typescript}}
    "ts-loader": "^9.0.0",
    {{/if}}
    {{#if vue2}}
    "vue-loader": "^15.9.6",
    "vue-template-compiler": "^2.6.12",
    {{else}}
    "@vue/compiler-sfc": "^3.0.6",
    "vue-loader": "^16.1.2",
    {{/if}}
    {{#if lint}}
    "eslint-plugin-vue": "^7.7.0",
    "vue-eslint-parser": "^7.6.0",
    {{/if}}
    {{/if}}
    "@babel/core": "^7.12.10",
    "@babel/plugin-proposal-class-properties": "^7.12.1",
    "@babel/plugin-transform-runtime": "^7.12.10",
    "@babel/preset-env": "^7.12.11",
    {{#if lint}}
    "@cybozu/eslint-config": "^11.0.3",
    "eslint": "^7.17.0",
    "eslint-config-airbnb": "^18.2.1",
    "eslint-config-prettier": "^7.2.0",
    "eslint-plugin-import": "^2.22.1",
    "eslint-plugin-prettier": "^3.3.1",
    "stylelint": "^13.8.0",
    "stylelint-config-prettier": "^8.0.2",
    "stylelint-config-rational-order": "^0.1.2",
    "stylelint-config-standard": "^20.0.0",
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
    "fs-extra": "^9.1.0",
    "inquirer": "^8.0.0",
    "prettier": "^2.2.1",
    "css-loader": "^5.0.1",
    "css-minimizer-webpack-plugin": "^1.2.0",
    "mini-css-extract-plugin": "^1.3.3",
    "postcss": "^8.2.4",
    "postcss-flexbugs-fixes": "^5.0.2",
    "postcss-loader": "^4.1.0",
    "postcss-normalize": "^9.0.0",
    "postcss-preset-env": "^6.7.0",
    {{#with style}}
    {{#if less}}
    "less": "^4.1.0",
    "less-loader": "^7.2.1",
    {{/if}}
    {{#if scss}}
    "node-sass": "^5.0.0",
    "sass-loader": "^10.1.0",
    {{/if}}
    {{/with}}
    "terser-webpack-plugin": "^5.1.1",
    "url-loader": "^4.1.1",
    "webpack": "^5.12.3",
    "webpack-cli": "^4.3.1",
    "webpack-merge": "^5.7.3"
  },
  "dependencies": {
    {{#if react}}
    "react": "^17.0.1",
    "react-dom": "^17.0.1",
    {{/if}}
    {{#if vue}}
    "vue": "^{{#if vue2}}2.6.12{{else}}3.0.11{{/if}}",
    {{/if}}
    "@babel/runtime-corejs3": "^7.12.5"
  }
}
