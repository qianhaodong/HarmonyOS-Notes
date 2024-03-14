@Extend(Text) function textStyle() {
  .fontSize(14)
  .fontColor('#545454')
  .lineHeight(20)
}

@Component
struct MineContent {
  @Builder contentBuilder1() {
    Stack() {
      Row() {
        Text('用户昵称')
          .fontSize(16)
          .fontColor('#2B364B')
          .layoutWeight(1)
        Column() {
          Text('已刷题数（道）')
            .fontSize(10)
            .fontColor('#979797')
            .lineHeight(16)
          Text('40')
            .fontSize(14)
            .fontColor('#2B364B')
            .lineHeight(20)
        }
        .margin({ right: 35 })
        Column() {
          Text('错题数量（道）')
            .fontSize(10)
            .fontColor('#979797')
            .lineHeight(16)
          Text('40')
            .fontSize(14)
            .fontColor('#2B364B')
            .lineHeight(20)
        }
      }
      .alignItems(VerticalAlign.Bottom)
      .padding({ top: 16, bottom: 4 })

      Image($r('app.media.user_logo'))
        .width(62)
        .height(62)
        .margin({ top: -43 })
    }
    .alignContent(Alignment.TopStart)
  }
  @Builder contentBuilder2() {
    Row() {
      Text('手机号码')
        .textStyle()
      Text('18879387844')
        .textStyle()
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ bottom: 12 })
    .border({
      color: '#F5F5F5',
      width: {
        bottom: 1
      }
    })

    Row() {
      Text('上次登陆时间')
        .textStyle()
      Text('2024/03/14 11:31')
        .textStyle()
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ top: 12 })
  }
  @Builder contentBuilder3() {
    Row() {
      Text('手机号：')
        .textStyle()
      Text('18879387844')
        .textStyle()
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .padding({ bottom: 12 })
    .border({
      color: '#F5F5F5',
      width: {
        bottom: 1
      }
    })

    Row() {
      Text('邮箱账号')
        .textStyle()
      Row() {
        Text('关联')
          .textStyle()
        Image($r('app.media.ic_right'))
          .width(16)
          .height(16)
          .margin({ left: 9 })
          .fillColor('#A6A3AD')
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ top: 12 })
  }
  @Builder contentBuilder4() {
    Row() {
      Text('登出')
        .textStyle()
      Image($r('app.media.ic_right'))
        .width(16)
        .height(16)
        .fillColor('#A6A3AD')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Column() {
      Box({
        contentBuilderParam: this.contentBuilder1
      }).margin({ top: 84, bottom: 20 })
      Box({
        contentBuilderParam: this.contentBuilder2
      }).margin({ bottom: 20 })
      Box({
        contentBuilderParam: this.contentBuilder3
      }).margin({ bottom: 12 })
      Box({
        contentBuilderParam: this.contentBuilder4
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
    // .backgroundColor('#f5f5f5')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#ffbabde9', 0], ['#fff', 1]]
    })
  }
}

@Component
struct Box {
  @Require @BuilderParam contentBuilderParam: () => void;

  build() {
    Column() {
      this.contentBuilderParam()
    }
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(8)
    .padding({ top: 12, right: 16, bottom: 12, left: 16 })
  }
}

export { MineContent }