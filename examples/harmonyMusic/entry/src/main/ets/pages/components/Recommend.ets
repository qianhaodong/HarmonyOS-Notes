@Component
struct Recommend {
  build() {
    Column() {
      SearchBox()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SearchBox {
  build() {
    Row() {
      Text('搜索')
    }
    // .width('100%')
    .height(48)
    .backgroundColor('#f1f1f1')
    .borderRadius(48)
    .margin({ left: 10, right:10, top: 10 })
  }
}

export { Recommend }