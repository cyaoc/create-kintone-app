{
  "search.exclude": {
    "**/node_modules": true,
    "dist": true,
    "yarn.lock": true
  },
  "editor.formatOnSave": true,
  "eslint.validate": [{{#each validate}}"{{this}}"{{#if @last}}{{else}}, {{/if}}{{/each}}],
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
  "editor.codeActionsOnSave": {
    {{#if style.css}}
    "source.fixAll.stylelint": true,
    {{/if}}
    "source.fixAll.eslint": true
  },
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
