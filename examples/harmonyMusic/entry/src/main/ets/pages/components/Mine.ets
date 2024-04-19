@Component
struct Mine {
  build() {
    Column() {
      Text('Mine')
        .fontColor('#fff')
    }
    .width('100%')
    .height('100%')
  }
}

export { Mine }