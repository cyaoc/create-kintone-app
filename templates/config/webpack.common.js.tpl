const { resolve } = require('path')
const isDev = process.env.NODE_ENV !== 'production'
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
{{#if typescript}}
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin')
{{/if}}
{{#if vue}}
const { VueLoaderPlugin } = require('vue-loader')
{{/if}}

const cssLoaders = (preNumber) => [
  isDev ? 'style-loader' : MiniCssExtractPlugin.loader,
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
  target: isDev ? 'web' : 'browserslist',
  entry: {
    app: resolve(__dirname, '../src/index{{suffix}}'),
  },
  output: {
    filename: `js/[name]${isDev ? '' : '.[contenthash:8]'}.js`,
    path: resolve(__dirname, '../dist'),
  },
  resolve: {
    extensions: [{{#each extensions}}'{{this}}', {{/each}}'.json'],
  },
  {{#if react}}
  // externals: {
  //   react: 'React',
  //   'react-dom': 'ReactDOM',
  // },
  {{/if}}
  plugins: [
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
