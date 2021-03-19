# create-kintone-app

A CLI tool for creating kintone app development templates!

## Usage

You can use the following commands to create a project

```
npx create-kintone-app ${name}
```

After the installation is successful, go to directory ${name}, you can run several commands:

```
npm start
```

Starts the development server.
Please set 'https://localhost:8080/js/app.js' to kintone's custom js field

```
npm run build
```

Builds optimized code under the dist directory.

```
npm run lint
```

Finds problems in your code.

```
npm run format
```

Formats the code.

## LICENSE

MIT License
