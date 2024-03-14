@Component
struct HomeContent {
  build() {
    Column() {
      Image($r('app.media.banner'))
        .width('100%')
        .height(140)
        .borderRadius(8)

      Row() {
        Row() {
          Column() {
            Text('在线答题')
              .fontSize(14)
              .fontColor('#3C3E42')
              .lineHeight(20)
            Text('123人参与')
              .fontSize(12)
              .fontColor('#979797')
              .lineHeight(20)
          }
          .alignItems(HorizontalAlign.Start)

          Image($r('app.media.ic_tests'))
            .width(38)
            .height(38)
        }
        .width(160)
        .height(68)
        .borderRadius(8)
        .backgroundColor('#fff')
        .padding({ left: 14, right: 14})
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Column() {
            Text('错题集合')
              .fontSize(14)
              .fontColor('#3C3E42')
              .lineHeight(20)
            Text('123道错题')
              .fontSize(12)
              .fontColor('#979797')
              .lineHeight(20)
          }
          Image($r('app.media.ic_problems'))
            .width(38)
            .height(38)
        }
        .width(160)
        .height(68)
        .borderRadius(8)
        .backgroundColor('#fff')
        .padding({ left: 14, right: 14})
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .margin({ top: 8, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)

      Text('答题排行榜')
        .fontSize(16)
        .fontColor('#000917')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 12 })
      Column() {
        Row() {
          Text('排名')
            .fontSize(13)
            .fontColor('#6F7579')
            .padding({ right: 32 })
          Text('昵称')
            .fontSize(13)
            .fontColor('#6F7579')
            .layoutWeight(1)
          Text('答题成绩')
            .fontSize(13)
            .fontColor('#6F7579')
        }
        .width('100%')
        .height(48)
        .padding({ left: 16, right: 16 })

        // 排行列表
        Column() {
          ForEach([1, 2, 3, 4, 5, 6, 7], (item: number, index) => {
            Column() {
              if ([0, 1, 2].includes(index)) {
                Stack() {
                  Image($r(`app.media.ic_${index + 1}`))
                    .width('100%')
                    .height(48)

                  Row() {
                    Row() {
                      Image($r('app.media.ic_public_avatar1'))
                        .width(40)
                        .height(40)
                        .margin({ left: 65, right: 8 })
                      Text('奔跑的蜗牛奔跑的蜗牛奔跑的蜗牛')
                        .width(80)
                        .fontSize(13)
                        .fontColor('#414149')
                        .maxLines(1)
                        .textOverflow({
                          overflow: TextOverflow.Ellipsis
                        })
                    }
                    .layoutWeight(1)
                    Text('100')
                      .width(30)
                      .height(20)
                      .fontSize(14)
                      .fontColor('#414149')
                      .fontWeight(FontWeight.Bold)
                      .textAlign(TextAlign.Center)
                      .margin({ left: 30, right: 10 })
                  }
                  .width('100%')
                }
                .width('100%')
                .padding({ left: 7, right: 16, bottom: 8 })
              } else {
                Row() {
                  Text(`${index +1}`)
                    .width(26)
                    .height(20)
                    .fontSize(13)
                    .fontColor('#414149')
                    .textAlign(TextAlign.Center)
                    .margin({ right: 35 })
                  Row() {
                    Image($r('app.media.ic_public_avatar1'))
                      .width(30)
                      .height(30)
                      .margin({ right: 8 })
                    Text('奔跑的蜗牛奔跑的蜗牛奔跑的蜗牛')
                      .width(80)
                      .fontSize(13)
                      .fontColor('#414149')
                      .maxLines(1)
                      .textOverflow({
                        overflow: TextOverflow.Ellipsis
                      })
                  }
                  .layoutWeight(1)
                  Text('100')
                    .width(30)
                    .height(20)
                    .fontSize(14)
                    .fontColor('#414149')
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                    .margin({ left: 30, right: 10 })
                }
                .width('100%')
                .padding({ left: 16, right: 16, bottom: 16 })
              }
            }
          })
        }
        .width('100%')
      }
      .width('100%')
      .backgroundColor('#F9FBFF')
      .borderRadius(8)
      .shadow({
        radius: 10,
        offsetX: 6,
        offsetY: 6,
        color: 'rgba(202, 212, 232, 0.64)'
      })
    }
    .height('100%')
    .padding({ top: 10 })
    .alignItems(HorizontalAlign.Start)
  }
}

export { HomeContent }