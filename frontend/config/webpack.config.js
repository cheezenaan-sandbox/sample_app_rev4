const path = require('path');

module.exports = {
  entry: { 'frontend/application': ['./src/javascripts/application/index.js'] },
  output: {
    filename: '[name].js',
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
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  devtool: 'cheap-module-source-map',
};
