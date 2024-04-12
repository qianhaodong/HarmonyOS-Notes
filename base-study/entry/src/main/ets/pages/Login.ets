import { router } from '@kit.ArkUI';
import { StoreManager } from '../utils/store';

@Entry
@Component
struct Login {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Button('登录')
          .onClick(() => {
            // 保存 token
            const token = `Token-${Math.random().toString().slice(2, 12)}`;
            StoreManager.setToken(token);

            // 跳转页面
            router.pushUrl({
              url: 'pages/Index'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}