// Remove pair of brackets
// https://mkloubert.github.io/vs-script-commands/index.html

exports.execute = async function(args) {
  const vscode = require('vscode');
  const editor = vscode.window.activeTextEditor;
  if (!editor) return 666;
  const doc = editor.document;
  await vscode.commands.executeCommand('editor.action.jumpToBracket');
  let pos1 = editor.selection.start;
  await vscode.commands.executeCommand('editor.action.jumpToBracket');
  let pos2 = editor.selection.start;
  if (pos1.isEqual(pos2)) return 666;
  if (pos1.isAfter(pos2)) {
    let pos3 = pos1;
    pos1 = pos2;
    pos2 = pos3;
  }
  const firstCharRange = new vscode.Range(pos1, pos1.translate(0, 1));
  const secondCharRange = new vscode.Range(pos2, pos2.translate(0, 1));
  const firstChar = doc.getText(firstCharRange);
  let outdent = false;
  editor.edit(editBuilder => {
    let secondRange = secondCharRange;
    if (firstChar === '{' && pos1.line != pos2.line) {
      let line = doc.lineAt(pos2.line);
      let lineRange = line.rangeIncludingLineBreak;
      pos1 = new vscode.Position(pos1.line + 1, 0);
      outdent = true;
      if (line.text.match(/^\s*}\s*$/)) {
        secondRange = lineRange;
      }
      pos2 = doc.lineAt(pos2.line - 1).range.end;
    }
    editBuilder.delete(firstCharRange);
    editBuilder.delete(secondRange);
  });
  if (pos1.line == pos2.line) pos2 = pos2.translate(0, -1);
  editor.selection = new vscode.Selection(pos1, pos2);
  if (outdent) vscode.commands.executeCommand('editor.action.outdentLines');
  return 666;
};
