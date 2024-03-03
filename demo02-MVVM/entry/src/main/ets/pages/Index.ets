@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('点击', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(25)
          .width(200)
          .height(50)

        TextInput().type(InputType.Password)
      }
      .width('100%')
    }
    .height('100%')
  }
}