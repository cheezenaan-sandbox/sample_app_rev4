const path = require('path');
const ManifestPlugin = require('webpack-manifest-plugin');
const UglifyJSPlugin = require('uglify-js-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const isProduction = process.env.NODE_ENV === 'production';
const fileName = isProduction ? '[name]_[hash]' : '[name]';

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
    'layouts/application': [
      './src/javascripts/application/index.js',
      './src/stylesheets/application.scss',
    ],
    'static_pages/home': ['./src/images/rails.png'],
  },
  output: {
    filename: `${fileName}.js`,
    path: path.resolve(__dirname, '../../public/assets/frontend'),
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
              outputPath: 'images/',
              publicPath: '/assets/',
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
  devtool: isProduction ? 'eval' : 'cheap-module-source-map',
};
