import { ReplyItemModel } from '../models/index'

@Component
struct HmCommentItem {
  @ObjectLink replyItem: ReplyItemModel;

  build() {
    Row() {
      Image(this.replyItem.avatar)
        .width(40)
        .height(40)
        .borderRadius(20)

      Column({ space: 10 }) {
        Text(this.replyItem.author)
          .fontSize(18)
          .fontColor('#303a43')
          .fontWeight(FontWeight.Bold)
        Text(this.replyItem.content)
          .fontColor('#2f3642')
          .lineHeight(22)

        Row() {
          Text(`${this.replyItem.time}.IP ${this.replyItem.area}`)
            .fontColor('#cacaca')
            .fontSize(12)

          Row() {
            Image($r('app.media.ic_public_like'))
              .width(12)
              .height(12)
              .fillColor(this.replyItem.likeFlag ? Color.Red : '#cacaca')

            Text(`${this.replyItem.likeNum}`)
              .fontSize(12)
              .fontColor(this.replyItem.likeFlag ? Color.Red : '#cacaca')
              .margin({ left: 3 })
          }
          .onClick(() => {
            // 点赞数量改变
            if (this.replyItem.likeFlag) {
              this.replyItem.likeNum--;
            } else {
              this.replyItem.likeNum++;
            }
            this.replyItem.likeFlag = !this.replyItem.likeFlag;
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 10 })
    }
    .padding({ left: 20, right: 20 })
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

export { HmCommentItem }