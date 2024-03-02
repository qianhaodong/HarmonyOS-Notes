@Entry
@Component
struct Index {
  scroller: Scroller = new Scroller();
  @State title: string = '线性布局';

  build() {
    Scroll(this.scroller) {
      Column({ space: 20 }) {
        Demo01()
        Demo02()
        Demo03()
        Demo04()
        Demo05()
      }
      .padding(20)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f1f1')
  }
}

// 线性布局
@Component
struct Demo01 {
  @State title: string = '1、线性布局';
  // 线性布局 Row、Column
  // Row 水平布局，主轴是水平方向，交叉轴是垂直方向
  // Column 垂直布局，主轴是垂直方向，交叉轴是水平方向

  // 对齐方式：
  // 1. 主轴方向使用 justifyContent() 方法，使用 FlexAlign 属性
  // 2. 交叉轴方向使用 alignItems() 方法，水平方向使用 HorizontalAlign 属性；垂直方向使用 VerticalAlign 方法。

  build() {
    Column() {
      Text(this.title).fontSize(20).margin({ bottom: 10 })

      Row() {
        Column().width(50).height('50%').backgroundColor('#ff9999')
        Column().width(50).height('50%').backgroundColor('#ff9999')
        Column().width(50).height('50%').backgroundColor('#ff9999')
      }
      .height('10%')
      .width('100%')
      .margin({ bottom: 20 })
      .backgroundColor('#9999ff')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row().height('10%').width('100%').backgroundColor('#9999ff')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// Blank 空白组件，自动伸缩
@Component
struct Demo02 {
  @State title: string = '2、自动伸缩：Blank 空白组件'

  build() {
    Column() {
      Text(this.title).fontSize(20).margin({ bottom: 10 })

      Row() {
        Text('Bluetooth').fontSize(20)
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: true })
      }
      .width('100%')
      .height(50)
      .backgroundColor('#fff')
      .borderRadius(25)
      .padding({ left: 10, right: 10 })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// 自适应缩放 layoutWeight
@Component
struct Demo03 {
  @State title: string = '3、自适应缩放：layoutWeight';

  build() {
    Column() {
      Text(this.title).fontSize(20).margin({ bottom: 10 })

      Row() {
        Text('1').width(100).height('100%').backgroundColor('#ff6699')
        Text('2').layoutWeight(1).height('100%').backgroundColor('#ffff99')
      }
      .height('15%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// flex布局
@Component
struct Demo04 {
  @State title: string = '4、flex布局';

  build() {
    Column() {
      Text(this.title).fontSize(20).margin({ bottom: 10 })

      Flex({
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center
      }) {
        Text('1').width('30%').height(100).backgroundColor('#000').fontColor('#fff').alignSelf(ItemAlign.Start)
        Text('2').width('30%').height(100).backgroundColor('#000').fontColor('#fff')
        Text('3').width('30%').height(100).backgroundColor('#000').fontColor('#fff').alignSelf(ItemAlign.End)
      }
      .width('100%')
      .height(200)
      .backgroundColor('#ff6666')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// 栅格布局
@Component
struct Demo05 {
  @State title: string = '5、栅格布局：GridRow, GridCol';
  @State bgColors: Color[] = [Color.Red, Color.Orange, Color.Yellow, Color.Green, Color.Pink, Color.Grey, Color.Blue, Color.Brown, Color.Red, Color.Orange, Color.Yellow, Color.Green];

  build() {
    Column() {
      Text(this.title).fontSize(20).margin({ bottom: 10 })
      
      GridRow({ columns: 4 }) {
        ForEach(this.bgColors, (item: Color, index?: number | undefined) => {
          GridCol() {
            Text(`${index}`)
          }
          .height(50)
          .backgroundColor(item)
        })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
