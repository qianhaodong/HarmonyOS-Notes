@Entry
@Component
struct DemoProvide {
  // @Provide、@Consume，用于父组件和后代组件双向数据同步
  // @Provide装饰的状态变量自动对其所有后代组件可用
  // 后代通过使用@Consume去获取@Provide提供的变量，建立在@Provide和@Consume之间的双向数据同步
  @Provide parentData: string = 'parent';

  build() {
    Column({ space: 10 }) {
      Text('父组件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button(`修改parentData = ${this.parentData}`)
        .onClick(() => {
          this.parentData = '父组件修改';
        })

      ChildProvide()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(20)
  }
}

@Component
struct ChildProvide {
  build() {
    Column({ space: 10 }) {
      Text('ChildProvide组件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      ChildItem2()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChildItem2 {
  @Consume parentData: string;

  build() {
    Column({ space: 10 }) {
      Text(`ChildItem2组件 - ${this.parentData}`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      ChildItem3()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChildItem3 {
  @Consume parentData: string;

  build() {
    Column({ space: 10 }) {
      Text('ChildItem3组件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button(`修改parentData = ${this.parentData}`)
        .onClick(() => {
          this.parentData = '后代组件修改';
        })

      Text(this.parentData)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
