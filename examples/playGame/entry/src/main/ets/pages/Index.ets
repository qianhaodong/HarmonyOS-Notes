import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Stack() {
      Image($r('app.media.startCover'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Contain)
        .objectRepeat(ImageRepeat.Y)

      Button('开始游戏')
        .backgroundColor(Color.Gray)
        .fontColor('#000')
        .border({
          width: 1,
          color: '#000'
        })
        .margin({ top: 500 })
        .onClick(() => {
          router.replaceUrl({
            url: 'pages/Game'
          })
        })
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Center)
  }
}