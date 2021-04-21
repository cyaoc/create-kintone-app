const { resolve } = require('path')
const isDev = process.env.NODE_ENV !== 'production'
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const webpack = require('webpack')
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

module.exports = {
  {{#if plugin}}
  entry: {
    desktop: resolve(__dirname, '../src/desktop{{suffix}}'),
    config: resolve(__dirname, '../src/config{{suffix}}'),
  },
  {{else}}
  target: isDev ? 'web' : 'browserslist',
  entry: {
    app: resolve(__dirname, '../src/index{{suffix}}'),
  },
  {{/if}}
  output: {
    filename: `js/[name]{{#if plugin}}{{else}}${isDev ? '' : '.[contenthash:8]'}{{/if}}.js`,
    path: resolve(__dirname, '../{{#if plugin}}plugin/{{/if}}dist'),
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
      process: {
        env: {},
      },
    }),
  {{#if plugin}}
    new MiniCssExtractPlugin({
      filename: 'css/[name].css',
      chunkFilename: 'css/[name].css',
    }),
  {{/if}}
  {{#if typescript}}
    new ForkTsCheckerWebpackPlugin({
      typescript: {
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
        exclude: /node_modules/,
      },
      {{#if vue}}
      {{#if typescript}}
      {
        test: /.ts$/,
        loader: 'ts-loader',
        options: { appendTsSuffixTo: [/\.vue$/] },
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
        use: 'url-loader',
      },
      {
        test: /\.(ttf|woff|woff2|eot|otf)$/,
        use: 'url-loader',
      },
    ],
  },
}
