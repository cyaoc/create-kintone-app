const { resolve } = require('path')
const isDev = process.env.NODE_ENV !== 'production'
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const webpack = require('webpack')
{{#if plugin}}
const CopyPlugin = require('copy-webpack-plugin')
{{/if}}
{{#if typescript}}
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin')
{{/if}}
{{#if vue}}
const { VueLoaderPlugin } = require('vue-loader')
{{/if}}

const cssLoaders = (preNumber) => [
  {{#if plugin}}
  MiniCssExtractPlugin.loader,
  {{else}}
  isDev ? 'style-loader' : MiniCssExtractPlugin.loader,
  {{/if}}
  {
    loader: 'css-loader',
    options: {
      sourceMap: isDev,
      importLoaders: preNumber + 1,
    },
  },
  {
    loader: 'postcss-loader',
    options: {
      postcssOptions: {
        plugins: [
          'postcss-flexbugs-fixes',
          [
            'postcss-preset-env',
            {
              autoprefixer: {
                grid: true,
                flexbox: 'no-2009',
              },
            },
          ],
          'postcss-normalize',
        ],
      },
      sourceMap: isDev,
    },
  },
]

const source = resolve(__dirname, '../src')
const output = resolve(__dirname, '../dist')

module.exports = {
  {{#if plugin}}
  entry: {
    desktop: resolve(source, 'js/desktop{{suffix}}'),
    config: resolve(source, 'js/config{{suffix}}'),
  },
  {{else}}
  entry: {
    app: resolve(source, 'index{{suffix}}'),
  },
  {{/if}}
  output: {
    filename: `js/[name]{{#if plugin}}{{else}}${isDev ? '' : '.[contenthash:8]'}{{/if}}.js`,
    path: output,
    clean: true,
  },
  resolve: {
    extensions: [{{#each extensions}}'{{this}}', {{/each}}'.json'],
  },
  externals: {
  {{#if plugin}}
    {{#if react}}
     react: 'React',
     'react-dom': 'ReactDOM',
    {{else if vue}}
     vue: 'Vue',
    {{/if}}
  {{/if}}
  },
  plugins: [
    new webpack.DefinePlugin({
      {{#if vue3}}
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: false,
      {{/if}}
      process: {
        env: {},
      },
    }),
  {{#if plugin}}
    new CopyPlugin({
      patterns: [{ from: source, to: output }],
    }),
    new MiniCssExtractPlugin({
      filename: 'css/[name].css',
      chunkFilename: 'css/[name].css',
    }),
  {{/if}}
  {{#if typescript}}
    new ForkTsCheckerWebpackPlugin({
      typescript: {
        {{#if vue}}
        vue: true,
        {{/if}}
        configFile: resolve(__dirname, '../tsconfig.json'),
      },
    }),
  {{/if}}
  {{#if vue}}
    new VueLoaderPlugin(),
  {{/if}}
  ],
  module: {
    rules: [
      {
        test: {{jsmatch}},
        loader: 'babel-loader',
        options: { cacheDirectory: true },
        exclude: {{#if vue}}(file) => /node_modules/.test(file) &&!/\.vue\.js{{#if typescript}}\.ts{{/if}}/.test(file),{{else}}/node_modules/,{{/if}}
      },
      {{#if vue}}
      {{#if typescript}}
      {
        test: /.ts$/,
        loader: 'ts-loader',
        options: {
          transpileOnly: true,
          appendTsSuffixTo: [/\.vue$/],
        },
        exclude: /node_modules/,
      },
      {{/if}}
      {
        test: /.vue$/,
        use: 'vue-loader',
      },
      {{/if}}
      {
        test: /\.css$/,
        use: cssLoaders(0),
      },
      {{#if style.less}}
      {
        test: /\.less$/,
        use: [
          ...cssLoaders(1),
          {
            loader: 'less-loader',
            options: {
              sourceMap: isDev,
              {{#if vue3}}
              lessOptions: {
                javascriptEnabled: true,
              },
              {{/if}}
            },
          },
        ],
      },
      {{/if}}
      {{#if style.scss}}
      {
        test: /\.scss$/,
        use: [
          ...cssLoaders(1),
          {
            loader: 'sass-loader',
            options: {
              sourceMap: isDev,
            },
          },
        ],
      },
      {{/if}}
      {
        test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/, /\.svg$/],
        type: 'asset/inline',
      },
      {
        test: /\.(ttf|woff|woff2|eot|otf)$/,
        type: 'asset/inline',
      },
    ],
  },
}
