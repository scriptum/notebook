// Quickly commit changes in current file
// https://mkloubert.github.io/vs-script-commands/index.html

exports.execute = function(args) {
  const vscode = require('vscode');
  const path = require('path');
  const exec = require('child_process').exec;

  const fail = function() {
    vscode.window.setStatusBarMessage('Internal script error', 5000);
    return 666;
  };

  const handleStdout = function(error, stdout, stderr) {
    if (error !== null) {
      vscode.window.setStatusBarMessage(`${error} ${stderr}`, 5000);
    }
  };

  let doc = vscode.window.activeTextEditor.document;
  if (!doc) return fail();

  let uri = doc.uri;
  if (!uri) return fail();

  let dir = path.dirname(uri.fsPath);
  let file = path.basename(uri.fsPath);

  vscode.window
    .showInputBox({
      placeHolder: 'Enter your commit message'
    })
    .then(message => {
      if (!message) {
        return;
      }
      doc.save();
      exec(`git -C "${dir}" add "${file}"`, handleStdout);
      exec(`git -C "${dir}" commit -m "${message}" "${file}"`, handleStdout);
    });

  return 666;
};
