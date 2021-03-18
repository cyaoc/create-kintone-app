<template>
  <div class="app">
    <h1>\{{ msg }}</h1>
  </div>
</template>

<script{{#if typescript}} lang="ts"{{/if}}>
export default {
  name: 'App',
  data() {
    return {
      msg: 'Hello kintone!',
    }
  },
}
</script>

<style>
@import 'normalize.css/opinionated.css';

.app {
  flex: 1;
  font-family: system-ui;
  text-align: center;
  background-color: #12345678;
}

::placeholder {
  color: rgb(128, 128, 128);
}
</style>
