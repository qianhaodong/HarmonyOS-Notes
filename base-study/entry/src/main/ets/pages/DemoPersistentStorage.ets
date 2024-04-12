// PersistentStorage 存储，是持久化存储；
// 数据存入磁盘，杀掉应用进程后，再次启动app，可以读取到上一次保存的数据。
// PersistentStorage 和 UIContext 相关联，需要在 UIContext 明确（页面中）的时候才可以调用。
// 如果没有在 UIContext 明确的地方（EntryAbility中）调用，将导致无法持久化数据。
PersistentStorage.persistProp('persistentNumber', 1);

@Entry
@Component
struct DemoPersistentStorage {
  @State message: string = 'Hello World';
  @StorageLink('persistentNumber') persistentNumber: number = 10;

  build() {
    Row() {
      Column() {
        Text(this.persistentNumber.toString())
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('增加')
          .onClick(() => {
            this.persistentNumber++;
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}