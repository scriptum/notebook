// Remove pair of brackets
// https://mkloubert.github.io/vs-script-commands/index.html

exports.execute = async function(args) {
  const vscode = require('vscode');
  const editor = vscode.window.activeTextEditor;
  if (!editor) return 666;
  await vscode.commands.executeCommand('editor.action.jumpToBracket');
  let pos1 = editor.selection.start;
  await vscode.commands.executeCommand('editor.action.jumpToBracket');
  let pos2 = editor.selection.start;
  if (pos1.isEqual(pos2)) {
    return 666;
  }
  if (pos1.isAfter(pos2)) {
    let pos3 = pos1;
    pos1 = pos2;
    pos2 = pos3;
  }
  editor.edit(editBuilder => {
    editBuilder.delete(new vscode.Range(pos1, pos1.translate(0, 1)));
    editBuilder.delete(new vscode.Range(pos2, pos2.translate(0, 1)));
  });
  if (pos1.line == pos2.line) pos2 = pos2.translate(0, -1);
  editor.selection = new vscode.Selection(pos1, pos2);
  return 666;
};
