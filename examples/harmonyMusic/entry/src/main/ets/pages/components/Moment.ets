import { momentList } from '../../constants';
import { ButtonListType, MomentListType } from '../../models';

@Component
struct Moment {
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
    Column({ space: 10 }) {
      Text('互动广场')
        .fontSize(16)
        .fontColor($r('app.color.color_white'))

      List() {
        ForEach(momentList, (item: MomentListType, index) => {
          ListItem() {
            Row({ space: 10 }) {
              Image(item.avatar)
                .width(40)
                .borderRadius(40)

              Column({ space: 10 }) {
                Text(item.author)
                  .fontSize(14)
                  .fontColor($r('app.color.color_white'))
                Text(item.content)
                  .fontSize(10)
                  .fontColor('#ffa49e9e')

                Row({ space: 10 }) {
                  Image(item.song.img)
                    .width(50)
                    .height(50)
                  Column({ space: 6 }) {
                    Text(item.song.name)
                      .fontSize(12)
                      .fontColor('#eaeaea')
                    Text(item.song.author)
                      .fontSize(10)
                      .fontColor('#ffa49e9e')
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                  Image($r('app.media.ic_single_play'))
                    .width(20)
                    .fillColor('#ececec')
                    .margin({ right: 12 })
                }
                .borderRadius(8)
                .clip(true)
                .backgroundColor('#45474b')

                Row({ space: 20 }) {
                  Row({ space: 4 }) {
                    Image($r('app.media.ic_share'))
                      .width(20)
                      .fillColor('#c9c8cd')
                    Text('分享')
                      .fontSize(12)
                      .fontColor('#ffa49e9e')
                  }
                  .height(30)

                  Row({ space: 4 }) {
                    Image($r('app.media.ic_comment_o'))
                      .width(20)
                      .fillColor('#c9c8cd')
                    Text(`${item.comment}`)
                      .fontSize(12)
                      .fontColor('#ffa49e9e')
                  }
                  .height(30)

                  Row({ space: 4 }) {
                    Image($r('app.media.ic_like'))
                      .width(20)
                      .fillColor('#c9c8cd')
                    Text(`${item.like}`)
                      .fontSize(12)
                      .fontColor('#ffa49e9e')
                  }
                  .height(30)
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
          }
          .padding({ top: 24, bottom: 24 })
          .border({
            color: '#ff2f2e2e',
            width: {
              bottom: index !== momentList.length - 1 ? 1 : 0
            }
          })
        })
      }
      .padding({ right: 10 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
  }
}

export { Moment }