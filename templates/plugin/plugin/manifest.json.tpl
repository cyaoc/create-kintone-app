{
  "manifest_version": 1,
  "version": 1,
  "type": "APP",
  "desktop": {
    "js": [
      {{#if react}}
      "https://unpkg.com/react@17/umd/react.production.min.js",
      "https://unpkg.com/react-dom@17/umd/react-dom.production.min.js",
      {{else if vue}}
      "https://cdn.jsdelivr.net/npm/vue@{{#if vue2}}2.6.12{{else}}3.0.5{{/if}}",
      {{/if}}
      "dist/js/desktop.js"
    ],
    "css": [
      "css/51-modern-default.css",
      "dist/css/desktop.css"
    ]
  },
  "icon": "image/icon.png",
  "config": {
    "html": "html/config.html",
    "js": [
      {{#if react}}
      "https://unpkg.com/react@17/umd/react.production.min.js",
      "https://unpkg.com/react-dom@17/umd/react-dom.production.min.js",
      {{else if vue}}
      "https://cdn.jsdelivr.net/npm/vue@{{#if vue2}}2.6.12{{else}}3.0.5{{/if}}",
      {{/if}}
      "dist/js/config.js"
    ],
    "css": [
      "css/51-modern-default.css",
      "dist/css/config.css"
    ],
    "required_params": [
      "message"
    ]
  },
  "name": {
    "en": "{{name}}",
    "ja": "{{name}}",
    "zh": "{{name}}"
  },
  "description": {
    "en": "{{#if description}}{{description}}{{else}}{{name}}{{/if}}",
    "ja": "{{#if description}}{{description}}{{else}}{{name}}{{/if}}",
    "zh": "{{#if description}}{{description}}{{else}}{{name}}{{/if}}"
  }
}
