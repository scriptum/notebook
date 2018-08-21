// Change current directory in terminal
// https://mkloubert.github.io/vs-script-commands/index.html

exports.execute = function(args) {
  const vscode = require('vscode');
  const path = require('path');
  const dir = path.dirname(vscode.window.activeTextEditor.document.uri.fsPath);
  const term = vscode.window.terminals[0];
  if (term) {
    term.show();
    term.sendText(`cd '${dir}'`, true);
  }
  return 666;
};
