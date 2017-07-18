const path = require('path');
const CommonsChunkPlugin = require('webpack/lib/optimize/CommonsChunkPlugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
var webpack = require('webpack');

module.exports = {
  entry: {
    'app': './src/scripts/app.ts',
    'vendor': './src/scripts/vendor.ts'    
  },
  output: {
    path: __dirname + '/dist',
    filename: './scripts/bundle.js'
  },
  plugins: [
    new webpack.ProvidePlugin({
      jquery: "jQuery",
      $: "jquery"
    }),
    new CommonsChunkPlugin({ name: 'vendor', filename: './scripts/vendor.bundle.js' }),
    new CopyWebpackPlugin([
      { from: './src/index.html', to: 'index.html' },
      { from: './src/favicon.ico', to: 'favicon.ico' },
      { from: './src/css/img/AppIcon.png', to: 'css/img/AppIcon.png' },
      { from: './src/css/app.css', to: 'css/app.css' },
      { from: 'node_modules/bootstrap/dist/css/bootstrap.css', to: "css/bootstrap.css" },
    ])
  ],
  resolve: {
    extensions: ['.ts', '.js']
  },
  module: {
    loaders: [
      { test: /\.ts$/, loader: 'ts-loader' }
    ],
    noParse: [path.join(__dirname, 'node_modules', 'bundles')]
  },
  devServer: {
    contentBase: 'src',
    historyApiFallback: true
  },
  devtool: 'source-map'
};