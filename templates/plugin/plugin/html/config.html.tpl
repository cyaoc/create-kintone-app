<section class="settings">
  <h2 class="settings-heading">Settings for {{name}}</h2>
  <p class="kintoneplugin-desc">This message is displayed on the app page after the app has been updated.</p>
  {{#if react}}
  <div id="main"></div>
  {{else if vue}}
  <div id="main"></div>
  {{else}}
  <form class="js-submit-settings">
    <p class="kintoneplugin-row">
      <label for="message">
        Message:
        <input type="text" class="js-text-message kintoneplugin-input-text" />
      </label>
    </p>
    <p class="kintoneplugin-row">
      <button type="button" class="js-cancel-button kintoneplugin-button-dialog-cancel">Cancel</button>
      <button class="kintoneplugin-button-dialog-ok">Save</button>
    </p>
  </form>
  {{/if}}
</section>
