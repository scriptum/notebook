// Run arbitrary commands
// https://mkloubert.github.io/vs-script-commands/index.html

exports.execute = function(args) {
  const vscode = require('vscode');
  const exec = require('child_process').exec;
  args.options.map(opt => {
    exec(eval(`\`${opt.cmd}\``), function(error, stdout, stderr) {
      if (error !== null) {
        vscode.window.setStatusBarMessage(`${error} ${stderr}`, 5000);
      }
    });
  });
  return 666;
};
