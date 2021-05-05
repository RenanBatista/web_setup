echo "****** SETUP MASTER ******"
echo "Installing Webpack packages..."
npm i webpack webpack-cli webpack-dev-server --save-dev > /dev/null 2>&1
npm i html-webpack-plugin --save-dev > /dev/null 2>&1
npm i tsconfig-paths-webpack-plugin > /dev/null 2>&1
npm i svg-url-loader --save-dev > /dev/null 2>&1
npm install sass-loader sass webpack --save-dev > /dev/null 2>&1
npm install @svgr/webpack --save-dev //Svg como componente > /dev/null 2>&1
touch webpack.config.js
cat <<EOT>> webpack.config.js
const ESLintPlugin = require('eslint-webpack-plugin');
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const TsconfigPathsPlugin = require('tsconfig-paths-webpack-plugin');
const path = require('path');
const Dotenv = require('dotenv-webpack');

const APP_PATH = path.resolve(__dirname, 'src');

module.exports = (env, argv) => {
  //Alterar o arquivo das variáveis de ambiente
  dotEnvPath = '.env.example';

  return {
    entry: APP_PATH,

    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, 'dist'),
      publicPath: '/',
    },

    devtool: 'source-map',

    resolve: {
      plugins: [new TsconfigPathsPlugin()],
      extensions: ['.ts', '.tsx', '.js', '.jsx', '.json'],
      modules: [path.join(__dirname, 'src'), 'node_modules'],
    },

    module: {
      rules: [
	{
        test: /\.s[ac]ss$/i,
        use: [
          // Creates `style` nodes from JS strings
          "style-loader",
          // Translates CSS into CommonJS
          "css-loader",
          // Compiles Sass to CSS
          "sass-loader",
        ],
      },
        {
          test: /\.tsx?$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env', '@babel/preset-react', '@babel/preset-typescript'],
            },
          },
        },
      ],
    },

    plugins: [
      new HtmlWebpackPlugin({ inject: true, template: path.join(APP_PATH, 'index.html') }),
      new ForkTsCheckerWebpackPlugin({ async: false }),
      new Dotenv({
        path: dotEnvPath,
      }),
      new ESLintPlugin({
        extensions: ['ts', 'tsx'],
      }),
    ],

    devServer: {
      open: true,
      historyApiFallback: true,
    },
  };
};
EOT

echo "Installing Eslint packages..."
npm i --save-dev eslint-webpack-plugin > /dev/null 2>&1
npm install eslint-plugin-import --save-dev
npm install eslint-plugin-react-hooks --save-dev

echo "Installing Babel packages..."
npm i @babel/core babel-loader @babel/preset-env @babel/preset-react --save-dev
npm install --save-dev babel-plugin-styled-components
npm install --save-dev babel-plugin-inline-react-svg
npm install --save-dev @babel/preset-typescript
touch .babelrc
cat <<EOT>> .babelrc
{
  "presets": [
    "@babel/env",
    "@babel/typescript",
    "@babel/react"
  ],
  "plugins": [
    //"@babel/proposal-class-properties",
    //"@babel/proposal-object-rest-spread"
  ]
}
EOT

echo "Installing Styled Components packages..."
npm install --save @types/styled-components
npm install --save styled-components

echo "Installing React packages..."
npm i react react-dom
npm i babel-preset-react

echo "Installing Typescript packages..."
npm install -g typescript
touch tsconfig.json

echo "Installing Prettier packages..."
touch .prettierrc
cat <<EOT>> .prettierrc
{
    "printWidth": 100,
    "singleQuote": true,
    "semi": true,
    "tabWidth": 2,
    "useTabs": false
  }
EOT

mkdir src
mkdir src/views
mkdir src/views/components
mkdir src/views/pages
mkdir src/types
mkdir src/store
touch src/store/app/actions.ts
touch src/store/app/reducer.ts
mkdir src/services
mkdir src/store/app
touch src/index.tsx
cat <<EOT>> src/index.tsx
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import App from './App';

import configureStore from './store';

export const store = configureStore();

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
);
EOT

touch src/app.tsx

touch src/index.html
cat <<EOT>> src/index.html
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <base href="/"> 
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>react-webpack-typescript-babel</title>
  <meta name="author" content="Renan F. Batista">
  <link href="index.css">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
</head>
<body style="background-color: #E5E5E5; margin: 0;">
  <div id="root"></div>
</body>
</html>
