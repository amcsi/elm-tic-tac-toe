var path = require('path');
var webpack = require('webpack');

const hostname = 'localhost';
const port = 8084;
const outputPath = path.join(__dirname, 'public/build');
const publicPath = '/build/';
console.info('outputPath', outputPath);

module.exports = {
  entry: {
    app: [
      `webpack-dev-server/client?http://localhost:${port}`,
      path.join(__dirname, 'app/index.js'),
    ],
  },
  output: {
    path: outputPath,
    filename: '[name].js',
    publicPath,
  },
  module: {
    loaders: [
      { test: /\.elm$/, loader: 'elm-webpack' },
      {
        // This is a custom property.
        name: 'jsx',
        test: /\.jsx?$/,
        loader: 'babel',
        query: {
          presets: ['es2015', 'stage-0'],
        },
        exclude: /node_modules/,
      },
    ],
    noParse: [/\.min\.js/, /.elm$/],
  },
  resolve: {
    extensions: ['', '.js', '.json', '.jsx', '.elm'],
    modulesDirectories: [
      'node_modules',
    ],
  },
  plugins: [
    new webpack.NoErrorsPlugin(),
  ],
  devServer: {
    contentBase: 'public',
    publicPath,
    hot: true,
    inline: true,
    lazy: false,
    quiet: false,
    noInfo: false,
    headers: { 'Access-Control-Allow-Origin': '*' },
    stats: { colors: true, chunks: false },
    host: hostname,
    port,
  },
};
