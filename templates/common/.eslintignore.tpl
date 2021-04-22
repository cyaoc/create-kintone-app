/node_modules
/config
/dist
.*.js
*.json
{{#if plugin}}
plugin/dist
{{/if}}
{{#if vue}}
{{#if typescript}}
src/*.d.ts
{{/if}}
{{/if}}
