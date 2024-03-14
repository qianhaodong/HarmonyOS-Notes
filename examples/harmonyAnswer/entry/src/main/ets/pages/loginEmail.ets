@Entry
@Component
struct LoginEmail {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Column({ space: 24 }) {
        TextInput({ placeholder: '请输入手机号' })
          .type(InputType.PhoneNumber)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#fff')

        Row() {
          TextInput({ placeholder: '请输入验证码' })
            .layoutWeight(1)
            .backgroundColor(Color.Transparent)
          Row() {
            Text('获取验证码')
              .fontSize(13)
              .fontColor('#2C80FF')
          }
        }
        .width('100%')
        .height(48)
        .backgroundColor('#fff')
        .borderRadius(24)
        .padding({ right: 16 })

        Button('登录')
          .height(48)
          .width('100%')
      }
      .layoutWeight(1)
      .padding({ left: 40, right: 40 })

      Row() {
        Radio({ value: 'protocol', group: 'protocol' })
          .width(12)
          .height(12)
        Text('登录即同意《用户使用协议》和《隐私政策》')
          .fontSize(12)
          .fontColor('#979797')
      }
      .padding({ bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7F9')
  }
}