import { ButtonListType, SongItemType } from '../../models';
import { songs } from '../../constants';

@Extend(Text) function textStyle() {
  .width(20)
  .margin({ right: 20 })
  .textAlign(TextAlign.Center)
}

@Component
struct Home {
  buttonList: ButtonListType[] = [
    {
      img: $r('app.media.ic_share'),
      title: '分享'
    },
    {
      img: $r('app.media.ic_comment'),
      title: '评论'
    },
    {
      img: $r('app.media.ic_collect'),
      title: '收藏'
    }
  ];

  @Builder buttonBuilder(item: ButtonListType) {
    Row({ space: 8 }) {
      Image(item.img)
        .width(20)
        .fillColor('#ec5c87')
      Text(item.title)
        .fontSize(12)
        .fontColor('#eaeaea')
    }
    .width(90)
    .height(30)
    .borderRadius(30)
    .backgroundColor('#ff353333')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Column() {
        Row({ space: 10 }) {
          Row() {
            Image($r('app.media.ic_favorite'))
              .width(60)
              .fillColor('#ff5186')
          }
          .width(90)
          .height(90)
          .backgroundColor('#fff')
          .borderRadius(8)
          .justifyContent(FlexAlign.Center)

          Column({ space: 10 }) {
            Text('我喜欢的音乐')
              .fontSize(16)
              .fontColor('#f1f1f1')
            Text('奔跑的蜗牛')
              .fontSize(12)
              .fontColor('#ffa49e9e')
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .margin({ bottom: 30 })

        Row() {
          ForEach(this.buttonList, (item: ButtonListType) => {
            this.buttonBuilder(item)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding({ top: 30, right: 16, bottom: 30, left: 16 })

      Column() {
        Row({ space: 8 }) {
          Image($r('app.media.ic_play'))
            .width(16)
            .fillColor('#ff5186')
          Text(`全部播放(${songs.length})`)
            .fontSize(14)
            .fontColor($r('app.color.color_white'))
        }
        .width('100%')
        .margin({ bottom: 10 })

        List() {
          ForEach(songs, (item: SongItemType, index) => {
            ListItem() {
              Row() {
                if (index === 0) {
                  Text(`${index + 1}`)
                    .textStyle()
                    .fontColor('#ffffe426')
                    .fontWeight(FontWeight.Bold)
                } else if (index === 1) {
                  Text(`${index + 1}`)
                    .textStyle()
                    .fontColor($r('app.color.primary_light'))
                    .fontWeight(FontWeight.Bold)
                } else if (index === 2) {
                  Text(`${index + 1}`)
                    .textStyle()
                    .fontColor($r('app.color.primary_dark'))
                    .fontWeight(FontWeight.Bold)
                } else {
                  Text(`${index + 1}`)
                    .textStyle()
                    .fontColor('#ffa49e9e')
                }

                Image(item.img)
                  .width(40)
                  .borderRadius(8)

                Column({ space: 4 }) {
                  Text(item.name)
                    .fontSize(14)
                    .fontColor('#ffa49e9e')
                  Text(item.author)
                    .fontSize(12)
                    .fontColor('#ffa49e9e')
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 10, right: 10 })

                Image($r('app.media.ic_more'))
                  .width(24)
                  .fillColor('#aaa9af')
              }
              .padding({ top: 10, bottom: 10 })
            }
          })
        }
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
      .backgroundColor('#ff353333')
      .borderRadius({
        topLeft: 12,
        topRight: 12,
      })
    }
    .width('100%')
    .height('100%')
  }
}

export { Home }