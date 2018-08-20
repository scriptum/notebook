# Visual Studio Code scripts

1. Install Script Commands extension
2. Add custom commands into user settings that execute scripts on this directory
3. Add keybindings/buttons and enjoy!

Example of user settings:

```json
{
  "script.commands": {
    "commands": [
      {
        "id": "mycmd.commit",
        "button": {
          "text": "⛁",
          "color": "#0a0"
        },
        "script": "/path/to/git/notebook/vscode/scripts/commit.js"
      },
      {
        "id": "mycmd.swap",
        "options": [
          {
            "from": "^(.*?) (.*?) (.*)$",
            "to": "$3 $2 $1"
          }
        ],
        "script": "/path/to/git/notebook/vscode/scripts/regexp.js"
      }
    ]
  }
}
```
