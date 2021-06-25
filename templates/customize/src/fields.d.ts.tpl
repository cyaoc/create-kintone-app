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
{{#if vue}}

declare module '*.vue' {
  import { ComponentOptions } from 'vue'

  const componentOptions: ComponentOptions
  export default componentOptions
}
{{/if}}

declare module '*.bmp' {
  const path: string
  export default path
}

declare module '*.gif' {
  const path: string
  export default path
}

declare module '*.jpg' {
  const path: string
  export default path
}

declare module '*.jpeg' {
  const path: string
  export default path
}

declare module '*.png' {
  const path: string
  export default path
}

declare module '*.svg' {
  const path: string
  export default path
}

declare module '*.ttf' {
  const path: string
  export default path
}

declare module '*.woff' {
  const path: string
  export default path
}

declare module '*.woff2' {
  const path: string
  export default path
}

declare module '*.eot' {
  const path: string
  export default path
}

declare module '*.otf' {
  const path: string
  export default path
}
