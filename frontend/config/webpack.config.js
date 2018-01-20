const path = require('path');
const ManifestPlugin = require('webpack-manifest-plugin');
const UglifyJSPlugin = require('uglify-js-plugin');

const isProduction = process.env.NODE_ENV === 'production';
const fileName = isProduction ? '[name]_[hash]' : '[name]';
const pathForAssets = path.resolve(__dirname, '../../public/assets');

const Manifest = new ManifestPlugin({ fileName: 'webpack-manifest.json' });
const UglifyJS = new UglifyJSPlugin({
  parallel: 4,
  sourceMap: !isProduction,
  warnings: false,
});

const plugins = [Manifest];
const pluginsForProudction = plugins.concat(UglifyJS);

module.exports = {
  entry: {
    'frontend/application': ['./src/javascripts/application/index.js'],
  },
  output: {
    filename: `${fileName}.js`,
    path: pathForAssets,
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
  plugins: isProduction ? pluginsForProudction : plugins,
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  devServer: isProduction ? {} : { contentBase: pathForAssets },
  devtool: isProduction ? 'eval' : 'cheap-module-source-map',
};
