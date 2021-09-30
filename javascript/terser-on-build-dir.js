const terser = require('terser');
const fs = require('fs');

const _options = {
  parse: {
    // parse options
  },
  compress: {
    // compress options
  },
  mangle: {
    // mangle options

    properties: {
      // mangle property options
    },
  },
  format: {
    // format options (can also use `output` for backwards compatibility)
  },
  sourceMap: {
    // source map options
  },
  ecma: 6, // specify one of: 5, 2015, 2016, etc.
  module: true,
};

const _dirPath = 'build/default/src';

/**
 * Recursively dive into dirpath.
 *
 * Ref: https://stackoverflow.com/q/7041638/6323360
 * @param {*} dirPath Directory path
 * @param {Function} action Function to take. Will accept func(dirPath: String)
 */
function dive(dirPath, action) {
  // Assert action is a function
  if (typeof action !== 'function') {
    console.err('action is not a function');
    return;
  }

  fs.readdir(dirPath, (err1, files) => {
    if (err1) {
      console.error('err on dirPath: ' + dirPath);
      return;
    }

    for (const file of files) {
      // Full path
      const fullPath = dirPath + '/' + file;
      // Get file's stats
      fs.stat(fullPath, (err2, stat) => {
        if (err2) {
          console.err('err on stat: ' + stat);
        } else if (stat && stat.isDirectory()) {
          // If directory
          dive(fullPath, action);
        } else {
          // If file
          action(fullPath);
        }
      });
    }
  });
}

/**
 * @param {String} file
 */
async function actionPerFile(file) {
  if (file.endsWith('js')) {
    console.info('File: ' + file);
    const result = await terser.minify(file, _options);
    console.debug(result);
  }
}

dive(_dirPath, actionPerFile);
