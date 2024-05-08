@Entry
@Component
struct DemoState {
  @State countState: number = 0;
  @State countProp: number = 0;

  build() {
    Row() {
      Column({ space: 10 }) {
        Button(`count计数：${this.countState}; countProp计数：${this.countProp}`)
          .onClick(() => {
            this.countState++;
            this.countProp++;
          })

        ChildState({ count: this.countState, countProp: this.countProp })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct ChildState {
  count: number = 0;
  @Prop countProp: number = 0;

  build() {
    Column({ space: 10 }) {
      Text(`Child组件，count：${this.count}`)
      Text(`Child组件，countProp：${this.countProp}`)
    }
  }
}