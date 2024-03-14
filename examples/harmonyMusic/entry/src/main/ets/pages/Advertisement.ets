import router from '@ohos.router';

@Entry
@Component
struct Advertisement {
  @State countdown: number = 5;
  timer: number | null = null;

  // 倒计时
  countdownHandler() {
    this.timer = setInterval(() => {
      this.countdown--;
      if (this.timer && this.countdown <= 0) {
        console.log('[countdownHandler]:clearInterval');
        clearInterval(this.timer);
        this.timer = null;

        // 跳页面
        router.replaceUrl({
          url: 'pages/Index'
        });
      }
      console.log('countdown: ', this.countdown);
    }, 1000);
  }

  aboutToAppear() {
    this.countdownHandler();
  }

  aboutToDisappear() {
    if (this.timer) {
      console.log('[aboutToDisappear]:clearInterval');
      clearInterval(this.timer);
    }
  }

  build() {
    Stack() {
      Image($r('app.media.ad'))
        .width('100%')
        .height('100%')

      Button(`跳过${this.countdown}s`)
        .width(80)
        .height(40)
        .backgroundColor('rgba(0,0,0,0.3)')
        .borderRadius(20)
        .margin({ top: 10, right: 10 })
        .onClick(() => {
          router.replaceUrl({
            url: 'pages/Index'
          })
        })
    }
    .alignContent(Alignment.TopEnd)
    .width('100%')
    .height('100%')
  }
}