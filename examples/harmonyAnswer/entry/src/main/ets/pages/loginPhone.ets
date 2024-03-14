import router from '@ohos.router';

@Entry
@Component
struct LoginPhone {
  title: string = '欢迎使用鸿蒙刷题';

  build() {
    Column() {
      Column() {
        Image($r('app.media.logo'))
          .width(90)
          .height(90)
          .margin({ top: 114 })
        Text(this.title)
          .margin({ top: 24, bottom: 24 })
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2B364B')

        Column({ space: 24 }) {
          TextInput({ placeholder: '请输入手机号' })
            .type(InputType.PhoneNumber)
            .height(48)
            .borderRadius(24)
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
          .backgroundColor('#F9F9F9')
          .borderRadius(24)
          .padding({ right: 16 })

          Button('登录')
            .height(48)
            .width('100%')
            .onClick(() => {
              console.log('login')
              router.replaceUrl({
                url: 'pages/Index'
              })
            })
        }
        .padding({ left: 40, right: 40 })
      }
      .layoutWeight(1)

      Column() {
        Column() {
          Text('其它方式登录')
            .lineHeight(28)
            .fontSize(12)
            .fontColor('#414149')
          Image($r('app.media.iconEmail'))
            .width(30)
            .height(30)
            .margin({ top: 8 })
        }
        .padding({ bottom: 60 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/loginEmail'
          })
        })

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
    }
    .width('100%')
    .height('100%')
  }
}