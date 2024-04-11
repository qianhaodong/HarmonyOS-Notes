import { AppDataType } from '../utils/common';

@Entry
@Component
struct DemoAppStorage {
  @State message: string = 'Hello World';
  @StorageLink('appData') appData: AppDataType = new AppDataType('', '');

  build() {
    Row() {
      Column() {
        Text(this.appData.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button(`修改：${this.appData.name}`)
          .onClick(() => {
            this.appData.name = '哈哈哈';
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}