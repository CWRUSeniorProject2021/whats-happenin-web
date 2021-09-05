const { environment } = require('@rails/webpacker')

const webpack = require('webpack');
const globImporter = require('node-sass-glob-importer');

environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
);

environment
  .loaders
  .get('sass')
  .use
  .find(item => item.loader === 'sass-loader')
  .options = { sassOptions: { importer: globImporter() } };

module.exports = environment
