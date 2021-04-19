{
  "name": "{{name}}",
  "version": "1.0.0",
  "description": "{{description}}",
  "scripts": {
    {{#if plugin}}
    "gen": "node bin/generate-private-key.js",
    {{/if}}
    "format": "prettier --write src",
    "lint": "eslint --fix -c .eslintrc.js --ext {{#each extensions}}{{this}}{{#if @last}}{{else}},{{/if}}{{/each}}{{#if vue}},.vue{{/if}} src && stylelint --config .stylelintrc.js src/**/*.{{#if style.less}}{css,less{{else if style.scss}}{css{{else}}{{#if vue}}{css,vue}{{else}}css{{/if}}{{/if}}{{#if style.scss}},scss{{#if vue}},vue{{/if~}}}{{else if style.less}}{{#if vue}},vue{{/if~}}}{{/if}}",
    "upload": "{{#if plugin}}kintone-plugin-uploader dist/{{name}}.zip --base-url ${sub-domain}.cybozu.cn --username ${username} --password ${password} --watch{{else}}kintone-customize-uploader --base-url ${sub-domain}.cybozu.cn --username ${username} --password ${password} customize-manifest.json{{/if}}",
    "start": "{{#if plugin}}{{else}}npm run upload && {{/if}}cross-env NODE_ENV=development webpack {{#if plugin}}{{else}}serve {{/if}}--config ./config/webpack.dev.js{{#if plugin}} & (wait-on plugin/dist/ && npm run gen && kintone-plugin-packer --watch --ppk plugin/private.ppk plugin --out dist/{{name}}.zip) & (wait-on dist/{{name}}.zip && npm run upload){{/if}}",
    "build": "cross-env NODE_ENV=production webpack --config ./config/webpack.prod.js{{#if plugin}} && npm run gen && kintone-plugin-packer --ppk plugin/private.ppk plugin --out dist/{{name}}.zip{{/if}}"
  },
  "keywords": [
    "kintone"
  ],
  "author": "{{author}}",
  "license": "ISC",
  "browserslist": ">0.2%, not dead, ie >= 11, not op_mini all",
  "devDependencies": {
    {{#if plugin}}
    "node-rsa": "^1.1.1",
    "@kintone/plugin-packer": "^4.0.3",
    "@kintone/plugin-uploader": "^4.3.0",
    "wait-on": "^5.3.0",
    {{else}}
    "@kintone/customize-uploader": "^3.1.12",
    "devcert": "^1.1.3",
    "webpack-dev-server": "^3.11.1",
    {{/if}}
    {{#if react}}
    "@babel/preset-react": "^7.12.10",
    "eslint-plugin-jsx-a11y": "^6.4.1",
    "eslint-plugin-react": "^7.22.0",
    "eslint-plugin-react-hooks": "^4.2.0",
    {{/if}}
    {{#if typescript}}
    "@babel/preset-typescript": "^7.12.7",
    "@kintone/dts-gen": "^3.1.0",
    "fork-ts-checker-webpack-plugin": "^6.1.0",
    "typescript": "^4.1.3",
    "@typescript-eslint/eslint-plugin": "^4.16.1",
    "@typescript-eslint/parser": "^4.16.1",
    {{#if react}}
    "@types/react": "^17.0.0",
    "@types/react-dom": "^17.0.0",
    {{/if}}
    {{else}}
    "@babel/eslint-parser": "^7.12.1",
    {{/if}}
    {{#if vue}}
    {{#if vue2}}
    "vue-loader": "^15.9.6",
    "vue-template-compiler": "^2.6.12",
    {{else}}
    "@vue/compiler-sfc": "^3.0.6",
    "vue-loader": "^16.1.2",
    {{/if}}
    "eslint-plugin-vue": "^7.7.0",
    "vue-eslint-parser": "^7.6.0",
    {{/if}}
    "@babel/core": "^7.12.10",
    "@babel/plugin-proposal-class-properties": "^7.12.1",
    "@babel/plugin-transform-runtime": "^7.12.10",
    "@babel/preset-env": "^7.12.11",
    "@cybozu/eslint-config": "^11.0.3",
    "babel-loader": "^8.2.2",
    "clean-webpack-plugin": "^3.0.0",
    "cross-env": "^7.0.3",
    "eslint": "^7.17.0",
    "eslint-config-airbnb": "^18.2.1",
    "eslint-config-prettier": "^7.2.0",
    "eslint-plugin-import": "^2.22.1",
    "eslint-plugin-prettier": "^3.3.1",
    "prettier": "^2.2.1",
    "css-loader": "^5.0.1",
    "css-minimizer-webpack-plugin": "^1.2.0",
    "mini-css-extract-plugin": "^1.3.3",
    "postcss": "^8.2.4",
    "postcss-flexbugs-fixes": "^5.0.2",
    "postcss-loader": "^4.1.0",
    "postcss-normalize": "^9.0.0",
    "postcss-preset-env": "^6.7.0",
    "style-loader": "^2.0.0",
    "stylelint": "^13.8.0",
    "stylelint-config-prettier": "^8.0.2",
    "stylelint-config-rational-order": "^0.1.2",
    "stylelint-config-standard": "^20.0.0",
    "stylelint-declaration-block-no-ignored-properties": "^2.3.0",
    "stylelint-order": "^4.1.0",
    "stylelint-prettier": "^1.2.0",
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
    "vue": "^{{#if vue2}}2.6.12{{else}}3.0.5{{/if}}",
    {{/if}}
    "@babel/runtime-corejs3": "^7.12.5"
  }
}
