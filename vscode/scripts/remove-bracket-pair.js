// Remove pair of brackets
// https://mkloubert.github.io/vs-script-commands/index.html

exports.execute = async function(args) {
  const vscode = require('vscode');
  const editor = vscode.window.activeTextEditor;
  if (!editor) return 666;
  const doc = editor.document;
  const cmd = 'editor.action.jumpToBracket';
  const currentWord = doc.getText(doc.getWordRangeAtPosition(editor.selection.start, /[\w</]{2,100}/));
  if (currentWord[0] == '<') {
    vscode.commands.executeCommand('editor.emmet.action.removeTag');
    return 666;
  }
  await vscode.commands.executeCommand(cmd);
  let pos1 = editor.selection.start;
  await vscode.commands.executeCommand(cmd);
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
    let firstRange = firstCharRange;
    let secondRange = secondCharRange;
    // remove block and unindent if curly brackets removed
    if (firstChar === '{' && pos1.line != pos2.line) {
      let lineFirst = doc.lineAt(pos1.line);
      let lineLast = doc.lineAt(pos2.line);
      pos1 = new vscode.Position(pos1.line + 1, 0);
      outdent = true;
      let shiftY = 0;
      if (lineFirst.text.match(/^\s*{\s*$/)) {
        firstRange = lineFirst.rangeIncludingLineBreak;
        pos1 = firstRange.end.translate(-1, 0);
        shiftY = -1;
        pos2 = secondRange.start.translate(-1, 0);
      }
      if (lineLast.text.match(/^\s*}\s*$/)) {
        secondRange = lineLast.rangeIncludingLineBreak;
      } else {
        shiftY = -1;
      }
      pos2 = secondRange.start.translate(shiftY, 0);
    }
    editBuilder.delete(firstRange);
    editBuilder.delete(secondRange);
  });
  if (outdent) {
    if (pos1.line == pos2.line) pos2 = pos2.translate(0, -1);
    editor.selection = new vscode.Selection(pos1, pos2);
    vscode.commands.executeCommand('editor.action.outdentLines');
    editor.selection = new vscode.Selection(pos1, pos1);
  }
  return 666;
};
