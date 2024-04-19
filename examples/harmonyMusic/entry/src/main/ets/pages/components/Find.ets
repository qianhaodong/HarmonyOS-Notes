import { SongItemType } from '../../models'
import { songs } from '../../constants';
import AVPlayerClass from '../../utils/AVPlayerClass';

@Component
struct Find {
  build() {
    Column() {
      Text('猜你喜欢')
        .fontColor('#fff')
        .margin({ bottom: 20 })

      List({ space: 12 }) {
        ForEach(songs, (item: SongItemType, index) => {
          ListItem() {
            Row() {
              Image(item.img)
                .width(60)
                .borderRadius(8)

              Column({ space: 10 }) {
                Text(item.name)
                  .fontSize(16)
                  .fontColor('#eaeaea')
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
          }
          .padding({ bottom: index === songs.length - 1 ? 20 : 0 })
          .onClick(() => {
            AVPlayerClass.multiplePlay(songs, index);
          })
        })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ top: 20, right: 20, left: 20 })
    .alignItems(HorizontalAlign.Start)
  }
}

export { Find }