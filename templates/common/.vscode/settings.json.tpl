{
  "search.exclude": {
    "**/node_modules": true,
    "dist": true,
    "yarn.lock": true
  },
  "editor.formatOnSave": true,
  {{#if typescript}}
  "typescript.tsdk": "./node_modules/typescript/lib",
  {{/if}}
  {{#if style.css}}
  "css.validate": false,
  {{/if}}
  {{#if style.less}}
  "less.validate": false,
  {{/if}}
  {{#if style.scss}}
  "scss.validate": false,
  {{/if}}
  {{#if lint}}
  "editor.codeActionsOnSave": {
    "source.fixAll.stylelint": true,
    "source.fixAll.eslint": true
  },
  {{/if}}
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
