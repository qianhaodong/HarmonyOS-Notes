@Entry
@Component
struct DemoLink {
  @State count: number = 0;

  build() {
    Column({ space: 10 }) {
      Text('父组件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button(`计数器，基数1：${this.count}`)
        .onClick(() => {
          this.count += 1;
        })

      ChildLink({ count: this.count })
    }
    .width('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChildLink {
  // @Link，父子组件双向数据同步
  // 禁止本地初始化；必须从父组件传值
  @Link count: number;

  build() {
    Column({ space: 10 }) {
      Text('ChildLink组件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button(`计数器，基数2：${this.count}`)
        .onClick(() => {
          this.count += 2;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}