import { SongItemType } from '../../models'
import { songs } from '../../constants';

@Component
struct Find {
  build() {
    Column() {
      Text('猜你喜欢')
        .fontColor('#fff')
        .margin({ bottom: 20 })

      List({ space: 10 }) {
        ForEach(songs, (item: SongItemType) => {
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
        })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
  }
}

export { Find }