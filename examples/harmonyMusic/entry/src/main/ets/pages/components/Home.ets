import { ButtonListType, SongItemType } from '../../models';
import { songs } from '../../constants';
import { PlayList } from './PlayList';

@Component
struct Home {
  @State playList: SongItemType[] = songs;

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

      PlayList({
        playList: this.playList
      })
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}

export { Home }