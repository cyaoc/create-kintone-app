{
  "compilerOptions": {
    "target": "es5",
    "module": "ESNext",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    {{#if react}}
    "jsx": "react",
    "isolatedModules": true,
    {{/if}}
    "declaration": true,
    "noEmit": true,
    "strict": true,
    "noImplicitAny": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true
  },
  "files": ["./node_modules/@kintone/dts-gen/kintone.d.ts"],
  "include": ["src/**/*"],
  "exclude": ["dist", "node_modules"]
}
