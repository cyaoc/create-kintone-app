const { merge } = require('webpack-merge')
const common = require('./webpack.common.js')
{{#if plugin}}
{{else}}
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
{{/if}}
const TerserPlugin = require('terser-webpack-plugin')
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin')

module.exports = merge(common, {
  mode: 'production',
  {{#if plugin}}
  {{else}}
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/[name].[contenthash:8].css',
      chunkFilename: 'css/[name].[contenthash:8].css',
    }),
  ],
  {{/if}}
  optimization: {
    minimizer: [
      new TerserPlugin({
        extractComments: false,
        terserOptions: {
          compress: { pure_funcs: ['console.log'] },
        },
      }),
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
    ],
    {{#if plugin}}
    {{else}}
    splitChunks: {
      cacheGroups: {
        commons: {
          test: /[\\/]node_modules[\\/]/,
          name(module, chunks, cacheGroupKey) {
            return `${cacheGroupKey}`
          },
          chunks: 'all',
        },
      },
    },
    {{/if}}
  },
})
