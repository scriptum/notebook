// Run a regular expression on the current selection
// Example:
// {
//     "id": "mycmd.swap",
//     "options": [
//         {
//             "from": "^(.*?) (.*?) (.*)$",
//             "to": "$3 $2 $1"
//         },
//         {
//             "from": "X",
//             "to": "Y"
//         }
//     ],
//     "script": "/path/to/git/notebook/vscode/scripts/regexp.js"
// }
// https://mkloubert.github.io/vs-script-commands/index.html

exports.execute = function (args) {
  const vscode = require('vscode');
  let editor = vscode.window.activeTextEditor;
  let document = editor.document;
  editor.edit(editBuilder => {
    editor.selections.map(sel => {
      let text = editor.document.getText(sel);
      args.options.map(opt => {
        let regexp = new RegExp(opt.from);
        text = text.replace(regexp, opt.to);
      });
      editBuilder.replace(sel, text);
    });
  })
  return 666;
}
