{
  "name": "{{name}}",
  "version": "1.0.0",
  "description": "{{description}}",
  "scripts": {
    "format": "prettier --write src",
    "lint": "npm run lint-eslint{{#if style.css}} && npm run lint-stylelint{{/if}}",
    "lint-eslint": "eslint --fix -c .eslintrc.js --ext {{#each extensions}}{{this}}{{#if @last}}{{else}},{{/if}}{{/each}} src",
    {{#if style.css}}
    "lint-stylelint": "stylelint --config .stylelintrc.js src/**/*.{{#if style.less}}{css,less{{else if style.scss}}{css{{else}}css{{/if}}{{#if style.scss}},scss}{{else if style.less~}} }{{/if}}",
    {{/if}}
    "start": "cross-env NODE_ENV=development webpack serve --config ./config/webpack.dev.js",
    "build": "cross-env NODE_ENV=production webpack --config ./config/webpack.prod.js"
  },
  "keywords": [
    "kintone"
  ],
  "author": "{{author}}",
  "license": "ISC",
  "browserslist": ">0.2%, not dead, ie >= 11, not op_mini all",
  "devDependencies": {
    {{#if react}}
    "@babel/preset-react": "^7.12.10",
    {{/if}}
    {{#if typescript}}
    "@babel/preset-typescript": "^7.12.7",
    "@kintone/dts-gen": "^3.1.0",
    "fork-ts-checker-webpack-plugin": "^6.1.0",
    "typescript": "^4.1.3",
    {{#if react}}
    "@types/react": "^17.0.0",
    "@types/react-dom": "^17.0.0",
    {{/if}}
    {{/if}}
    "@babel/core": "^7.12.10",
    "@babel/eslint-parser": "^7.12.1",
    "@babel/plugin-proposal-class-properties": "^7.12.1",
    "@babel/plugin-transform-runtime": "^7.12.10",
    "@babel/preset-env": "^7.12.11",
    "@cybozu/eslint-config": "^11.0.3",
    "babel-loader": "^8.2.2",
    "clean-webpack-plugin": "^3.0.0",
    "cross-env": "^7.0.3",
    "devcert": "^1.1.3",
    "eslint": "^7.17.0",
    "prettier": "^2.2.1",
    {{#with style}}
    {{#if css}}
    "css-loader": "^5.0.1",
    "css-minimizer-webpack-plugin": "^1.2.0",
    "glob": "^7.1.6",
    "mini-css-extract-plugin": "^1.3.3",
    "postcss": "^8.2.4",
    "postcss-flexbugs-fixes": "^5.0.2",
    "postcss-loader": "^4.1.0",
    "postcss-normalize": "^9.0.0",
    "postcss-preset-env": "^6.7.0",
    "purgecss-webpack-plugin": "^3.1.3",
    "style-loader": "^2.0.0",
    "stylelint": "^13.8.0",
    "stylelint-config-prettier": "^8.0.2",
    "stylelint-config-rational-order": "^0.1.2",
    "stylelint-config-standard": "^20.0.0",
    "stylelint-declaration-block-no-ignored-properties": "^2.3.0",
    "stylelint-order": "^4.1.0",
    {{/if}}
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
    "webpack-bundle-analyzer": "^4.3.0",
    "webpack-cli": "^4.3.1",
    "webpack-dev-server": "^3.11.1",
    "webpack-merge": "^5.7.3"
  },
  "dependencies": {
    {{#if react}}
    "react": "^17.0.1",
    "react-dom": "^17.0.1",
    {{/if}}
    "@babel/runtime-corejs3": "^7.12.5"
  }
}
