const path = require('path');
const ManifestPlugin = require('webpack-manifest-plugin');

module.exports = {
  entry: { 'frontend/application': ['./src/javascripts/application/index.js'] },
  output: {
    filename: '[name].js', // TODO: define as [name]_[hash] when production
    path: path.resolve(__dirname, '../../public/assets'),
  },
  module: {
    rules: [
      {
        test: /.js$/,
        exclude: /node_modules|bower_components/,
        loader: 'babel-loader',
      },
    ],
  },
  plugins: [new ManifestPlugin({ fileName: 'webpack-manifest.json' })],
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  devtool: 'cheap-module-source-map',
  devServer: {
    contentBase: path.resolve(__dirname, '../../public/assets'),
  },
};
