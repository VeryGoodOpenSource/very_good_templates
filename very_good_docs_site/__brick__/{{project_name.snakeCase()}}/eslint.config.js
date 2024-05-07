const babelParser = require('@babel/eslint-parser');

module.exports = [
  {
    files: ['**/*.js'],
    languageOptions: {
      parser: babelParser,
      parserOptions: {
        ecmaVersion: 'latest',
        sourceType: 'module',
      },
    },
    rules: {
      semi: 'error',
      'no-unused-vars': 'error',
    },
  },
];