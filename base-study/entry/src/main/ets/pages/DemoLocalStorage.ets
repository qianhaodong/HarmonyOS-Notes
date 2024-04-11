import { PersonLocal } from '../utils/common';

// 获得全局共享的 localStorage 实例
const storage = LocalStorage.getShared();

@Entry(storage)
@Component
struct DemoLocalStorage {
  @LocalStorageProp('user') user: PersonLocal = new PersonLocal('DemoLocalStorage', 24);

  build() {
    Row() {
      Column() {
        Text(this.user.name + '-' + this.user.age)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        DemoLocalStorageLink()
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct DemoLocalStorageLink {
  // 子组件实例将自动获得对该 localStorage 实例的访问权限
  @LocalStorageLink('user') user: PersonLocal = new PersonLocal('DemoLocalStorageLink', 20);
  @LocalStorageLink('message') message: string = '';

  build() {
    Column() {
      Text(this.user.age.toString())
        .fontSize(50)

      Button(`message: ${this.message}`)
        .onClick(() => {
          this.user.age++;
          this.message = 'hello';
        })
    }
  }
}