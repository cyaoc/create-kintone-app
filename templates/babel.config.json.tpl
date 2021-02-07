{
  "presets": [
    [
      "@babel/preset-env",
      {
        "modules": false
      }
    ]
    {{#if react}}
    ,"@babel/preset-react"
    {{/if}}
    {{#if typescript}}
    ,"@babel/preset-typescript"
    {{/if}}
  ],
  "plugins": [
    "@babel/plugin-proposal-class-properties",
    [
      "@babel/plugin-transform-runtime",
      {
        "corejs": {
          "version": 3,
          "proposals": true
        },
        "useESModules": true
      }
    ]
  ]
}
