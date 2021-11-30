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
      "https://cdn.jsdelivr.net/npm/vue@{{#if vue2}}2.6.14{{else}}3.2.21{{/if}}",
      {{/if}}
      "$desktop"
    ],
    "css": [
      "css/51-modern-default.css",
      "$desktop"
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
      "https://cdn.jsdelivr.net/npm/vue@{{#if vue2}}2.6.14{{else}}3.2.21{{/if}}",
      {{/if}}
      "$config"
    ],
    "css": [
      "css/51-modern-default.css",
      "$config"
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
