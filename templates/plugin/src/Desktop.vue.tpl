<template>
  <div>
    <h3 class="plugin-space-heading">Hello kintone plugin!</h3>
    <p class="plugin-space-message">\{{ msg }}</p>
  </div>
</template>

<script{{#if typescript}} lang="ts"{{/if}}>
export default {
  name: 'Desktop',
  props: {
    msg: {
      type: String,
      default: '',
    },
  },
}
</script>

<style>
@import 'normalize.css/opinionated.css';
@import 'desktop.css';
</style>
