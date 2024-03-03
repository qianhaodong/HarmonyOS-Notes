// 全局自定义构建函数
@Builder function globalBuilderHandler() {
  Button('点击', { type: ButtonType.Normal })
    .width(200)
    .height(40)
    .borderRadius(20)
}

@Entry
@Component
struct Index {
  @State message: string = 'parent';
  @State title: string = '父组件标题';

  // 页面生命周期
  // 只有被 @Enter 装饰过的组件，才能调用页面的生命周期
  onPageShow() {
    console.log('index onPageShow');
  }
  onPageHide() {
    console.log('index onPageHide');
  }
  onBackPress(): boolean | void {
    console.log('index onBackPress');
  }

  // 组件的生命周期
  aboutToAppear() {
    console.log('index aboutToAppear');
  }
  aboutToDisappear() {
    console.log('index aboutToDisappear');
  }

  // @Builder装饰器，用来定义自定义构建函数
  // 自定义构建函数
  @Builder parentBuilderHandler() {
    Text(this.title)
      .fontSize(40)
      .fontWeight(FontWeight.Bold)
  }

  build() {
    Row() {
      Column({ space: 20 }) {
        Text('hello')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        child({
          childBuilderParamHandler: this.parentBuilderHandler
        })

        // 全局自定义构建函数使用
        globalBuilderHandler()
      }
      .width('100%')
    }
    .height('100%')
  }
}

// @Extend装饰器：定义扩展组件样式
// 支持传参，只能全局定义

@Component
struct child {
  @State message: string = 'child';
  @State title: string = '子组件标题';

  @Builder childBuilderHandler() {
    Text(this.message)
      .fontSize(50)
      .fontWeight(FontWeight.Bold)
  }

  // @BuilderParam装饰器，用来引用@Builder函数（类似于插槽）
  @BuilderParam childBuilderParamHandler: () => void = this.childBuilderHandler;

  // @Styles装饰器，定义组件重用样式
  // 不支持传参，可以在组件内部声明
  @Styles btnStyle() {
    .width(150)
    .height(40)
    .borderRadius(20)
  }

  build() {
    Column({ space: 10 }) {
      this.childBuilderParamHandler()

      Button('child-btn', { type: ButtonType.Normal })
        .btnStyle()
        .backgroundColor('#ff9999')
    }
  }
}