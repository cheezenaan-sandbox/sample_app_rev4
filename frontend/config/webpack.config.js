const path = require('path');
const ManifestPlugin = require('webpack-manifest-plugin');
const UglifyJSPlugin = require('uglify-js-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const isProduction = process.env.NODE_ENV === 'production';
const fileName = isProduction ? '[name]_[hash]' : '[name]';
const destinationPath = path.resolve(__dirname, '../../public/assets');
const publicPath = isProduction ? '/assets/' : 'http://0.0.0.0:4000/assets/';

const Manifest = new ManifestPlugin({ fileName: 'webpack-manifest.json' });
const UglifyJS = new UglifyJSPlugin({
  parallel: 4,
  sourceMap: !isProduction,
  warnings: false,
});
const ExtractCSS = new ExtractTextPlugin(`${fileName}.css`);

const plugins = [Manifest, ExtractCSS];
const pluginsForProudction = plugins.concat(UglifyJS);

module.exports = {
  entry: {
    'frontend/application': ['./src/javascripts/application/index.js'],
    'frontend/layouts/application': ['./src/stylesheets/application.scss'],
  },
  output: {
    filename: `${fileName}.js`,
    path: destinationPath,
    publicPath,
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules|bower_components/,
        loader: 'babel-loader',
      },
      {
        test: /\.s?css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: ['css-loader', 'postcss-loader', 'sass-loader'],
        }),
      },
      {
        test: /\.png$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: `${fileName}.[ext]`,
              outputPath: 'frontend/images/',
              publicPath,
            },
          },
        ],
      },
    ],
  },
  plugins: isProduction ? pluginsForProudction : plugins,
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  devServer: isProduction ? {} : { contentBase: destinationPath },
  devtool: isProduction ? 'eval' : 'cheap-module-source-map',
};
