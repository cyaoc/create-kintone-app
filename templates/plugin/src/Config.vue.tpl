<template>
  <form class="js-submit-settings" @submit.prevent="handleSubmit">
    <p class="kintoneplugin-row">
      <label for="message">
        Message:
        <input ref="msg" type="text" :value="msg" class="js-text-message kintoneplugin-input-text" />
      </label>
    </p>
    <p class="kintoneplugin-row">
      <button type="button" class="js-cancel-button kintoneplugin-button-dialog-cancel" @click="handleCancel">
        Cancel
      </button>
      <button type="submit" class="kintoneplugin-button-dialog-ok">Save</button>
    </p>
  </form>
</template>

<script{{#if typescript}} lang="ts"{{/if}}>
{{#if vue2}}
import Vue from 'vue'
{{else}}
import { defineComponent } from 'vue'
{{/if}}

export default {{#if vue2}}Vue.extend{{else}}defineComponent{{/if}}({
  name: 'Config',
  props: {
    msg: {
      type: String,
      default: '',
    },
  },
  methods: {
    handleSubmit() {
      const input = this.$refs.msg{{#if typescript}} as HTMLInputElement{{/if}}
      kintone.plugin.app.setConfig({ message: input.value }, () => {
        window.location.href = `../../flow?app=${kintone.app.getId()}`
      })
    },
    handleCancel() {
      window.location.href = `../../${kintone.app.getId()}/plugin/`
    },
  },
})
</script>

<style>
@import 'normalize.css/opinionated.css';
@import 'config.css';
</style>
