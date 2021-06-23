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
@import 'normalize.css';
@import 'app.css';
</style>
