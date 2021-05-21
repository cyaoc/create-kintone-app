{{#if plugin}}
declare namespace kintone {
  const $PLUGIN_ID: string
}
{{#if react}}

type ConfigProps = {
  message: string
}
{{/if}}

{{/if}}
declare namespace kintone.types {
  interface Fields {}
  interface SavedFields extends Fields {
    $id: kintone.fieldTypes.Id
    $revision: kintone.fieldTypes.Revision
    更新人: kintone.fieldTypes.Modifier
    创建人: kintone.fieldTypes.Creator
    更新时间: kintone.fieldTypes.UpdatedTime
    创建时间: kintone.fieldTypes.CreatedTime
    key: kintone.fieldTypes.RecordNumber
  }
}

interface KintoneEvent {
  record: kintone.types.SavedFields
}
