@Entry
@Component
struct DemoPageLifeCycle {
  @State message: string = '页面';

  aboutToAppear() {
    console.log('page-aboutToAppear')
  }

  onPageShow() {
    console.log('page-onPageShow')
  }

  onPageHide() {
    console.log('page-onPageHide')
  }

  onBackPress() {
    console.log('page-onBackPress')
  }

  aboutToDisappear() {
    console.log('page-aboutToDisappear')
  }

  build() {
    Row() {
      Column({ space: 20 }) {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        PageChild()
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct PageChild {
  aboutToAppear() {
    console.log('Component-aboutToAppear')
  }

  aboutToDisappear() {
    console.log('Component-aboutToDisappear')
  }

  build() {
    Column() {
      Text('组件')
    }
  }
}