{
  "name": "{{name}}",
  "version": "1.0.0",
  "description": "{{description}}",
  "scripts": {
    "format": "prettier --write src",
    {{#if lint}}
    "lint": "eslint --fix -c .eslintrc.js --ignore-path .eslintignore --ext {{#each extensions}}{{this}}{{#if @last}}{{else}},{{/if}}{{/each}}{{#if vue}},.vue{{/if}} src && stylelint --config .stylelintrc.js src/**/*.{{#if style.less}}{css,less{{else if style.scss}}{css{{else}}{{#if vue}}{css,vue}{{else}}css{{/if}}{{/if}}{{#if style.scss}},scss{{#if vue}},vue{{/if~}}}{{else if style.less}}{{#if vue}},vue{{/if~}}}{{/if}}",
    {{/if}}
    "start": "cross-env NODE_ENV=development node ./scripts/server.js",
    {{#if plugin}}
    {{else}}
    "debug": "cross-env NODE_ENV=debug node ./scripts/debug.js",
    {{/if}}
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
    "copy-webpack-plugin": "^9.0.1",
    {{/if}}
    {{#if react}}
    "@babel/preset-react": "^7.16.0",
    {{#if lint}}
    "eslint-plugin-jsx-a11y": "^6.5.1",
    "eslint-plugin-react": "^7.27.0",
    "eslint-plugin-react-hooks": "^4.3.0",
    {{/if}}
    {{/if}}
    {{#if typescript}}
    "@babel/preset-typescript": "^7.16.0",
    "@kintone/dts-gen": "^5.0.9",
    "fork-ts-checker-webpack-plugin": "^6.4.0",
    "typescript": "^4.4.4",
    {{#if lint}}
    "@typescript-eslint/eslint-plugin": "^5.3.1",
    "@typescript-eslint/parser": "^5.3.1",
    {{/if}}
    {{#if react}}
    "@types/react": "^17.0.34",
    "@types/react-dom": "^17.0.11",
    {{/if}}
    {{else}}
    {{#if lint}}
    "@babel/eslint-parser": "^7.16.3",
    {{/if}}
    {{/if}}
    {{#if vue}}
    {{#if typescript}}
    "ts-loader": "^9.2.6",
    {{/if}}
    {{#if vue2}}
    "vue-loader": "^15.9.8",
    "vue-template-compiler": "^2.6.14",
    {{else}}
    "@vue/compiler-sfc": "^3.2.21",
    "vue-loader": "^16.8.3",
    {{/if}}
    {{#if lint}}
    "eslint-plugin-vue": "^8.0.3",
    "vue-eslint-parser": "^8.0.1",
    {{/if}}
    {{/if}}
    "@babel/core": "^7.16.0",
    "@babel/plugin-proposal-class-properties": "^7.16.0",
    "@babel/plugin-transform-runtime": "^7.16.0",
    "@babel/preset-env": "^7.16.0",
    {{#if lint}}
    "@cybozu/eslint-config": "^16.0.0",
    "eslint": "^8.2.0",
    "eslint-config-airbnb": "^19.0.0",
    "eslint-config-prettier": "^8.3.0",
    "eslint-plugin-import": "^2.25.3",
    "eslint-plugin-prettier": "^4.0.0",
    "stylelint": "^14.1.0",
    "stylelint-config-prettier": "^9.0.3",
    "stylelint-config-standard": "^24.0.0",
    "stylelint-prettier": "^2.0.0",
    {{/if}}
    "babel-loader": "^8.2.3",
    "cross-env": "^7.0.3",
    "prettier": "^2.4.1",
    "css-loader": "^6.5.1",
    "css-minimizer-webpack-plugin": "^3.1.3",
    "kintone-dev-tools": "^1.0.9",
    "mini-css-extract-plugin": "^2.4.4",
    "postcss": "^8.3.11",
    "postcss-flexbugs-fixes": "^5.0.2",
    "postcss-loader": "^6.2.0",
    "postcss-preset-env": "^6.7.0",
    {{#with style}}
    {{#if less}}
    "less": "^4.1.2",
    "less-loader": "^10.2.0",
    {{/if}}
    {{#if scss}}
    "sass": "^1.43.4",
    "sass-loader": "^12.3.0",
    {{/if}}
    {{/with}}
    "style-loader": "^3.3.1",
    "terser-webpack-plugin": "^5.2.5",
    "webpack": "^5.63.0",
    "webpack-cli": "^4.9.1",
    "webpack-dev-server": "^4.4.0",
    "webpack-merge": "^5.8.0"
  },
  "dependencies": {
    {{#if react}}
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    {{/if}}
    {{#if vue}}
    "vue": "^{{#if vue2}}2.6.14{{else}}3.2.21{{/if}}",
    {{/if}}
    "@babel/runtime-corejs3": "^7.16.3"
  }
}
