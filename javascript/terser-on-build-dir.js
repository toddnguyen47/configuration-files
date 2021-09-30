const {exec} = require('child_process');
const fs = require('fs');

// Ref: https://www.npmjs.com/package/terser
// Comma separated list of compress options. NO SPACES
const _compressOptions = 'defaults=true,arrows=true';
// Comma separated list of mangle options. NO SPACES
const _mangleOptions = '';
const _terserCommand =
  './node_modules/terser/bin/terser ' +
  `--compress ${_compressOptions} ` +
  `--mangle ${_mangleOptions} `;
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
 * @param {String} file Fullpath to file
 */
async function actionPerFile(file) {
  if (file.endsWith('js')) {
    const command = _terserCommand + '--output ' + file + ' -- ' + file;
    console.info('Command: ' + command);
    exec(command, (err1, _stdout, _stderr) => {
      if (err1) {
        console.error(`error: ${err1}`);
      }
    });
  }
}

dive(_dirPath, actionPerFile);
