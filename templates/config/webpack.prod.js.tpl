const { merge } = require('webpack-merge')
const common = require('./webpack.common.js')
const { CleanWebpackPlugin } = require('clean-webpack-plugin')
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer')
const TerserPlugin = require('terser-webpack-plugin')
{{#if style.css}}
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin')
const { resolve } = require('path')
const glob = require('glob')
const PurgeCSSPlugin = require('purgecss-webpack-plugin')
{{/if}}

module.exports = merge(common, {
  mode: 'production',
  plugins: [
    new CleanWebpackPlugin(),
    {{#if style.css}}
    new PurgeCSSPlugin({
      paths: glob.sync(`${resolve(__dirname, '../src')}/**/*.{js,jsx,ts,tsx,scss,less,css}`, { nodir: true }),
    }),
    new MiniCssExtractPlugin({
      filename: 'css/[name].[contenthash:8].css',
      chunkFilename: 'css/[name].[contenthash:8].css',
    }),
    {{/if}}
    new BundleAnalyzerPlugin(),
  ],
  optimization: {
    minimizer: [
      new TerserPlugin({
        extractComments: false,
        terserOptions: {
          compress: { pure_funcs: ['console.log'] },
        },
      }),
      {{#if style.css}}
      new CssMinimizerPlugin({
        minimizerOptions: {
          preset: [
            'default',
            {
              discardComments: { removeAll: true },
            },
          ],
        },
      }),
      {{/if}}
    ],
    splitChunks: {
      chunks: 'all',
    },
  },
})
