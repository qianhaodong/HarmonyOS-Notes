
interface ListType {
  title: string
  content?: string
  list?: ListType[]
}

@Entry
@Component
struct DemoProp {
  @State list: ListType[] = [
    {
      title: '一级标题1',
      list: [
        {
          title: '二级标题1',
          content: '二级内容1'
        },
        {
          title: '二级标题2',
          content: '二级内容2'
        },
      ]
    },
    {
      title: '一级标题2',
      list: [
        {
          title: '二级标题1',
          content: '二级内容1'
        }
      ]
    },
    {
      title: '一级标题3',
      content: '一级内容3'
    },
  ]

  build() {
    Column({ space: 20 }) {
      Text('父组件：')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button('增加一级标题')
        .onClick(() => {
          this.list.push({
            title: '一级标题666',
            content: '一级内容666'
          })
        })

      Button('修改二级标题')
        .onClick(() => {
          // 二级对象属性值的变化，监听不到
          this.list[0].title = '2333';
          this.list[0].list?.push({
            title: '二级标题3',
            content: '二级内容3'
          })
        })

      ChildProp({ list: this.list })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChildProp {
  // @Prop：单项数据同步，从父组件到子组件
  // 可以本地初始化；非必选参数
  @Prop list: ListType[] = [];

  build() {
    Column({ space: 10 }) {
      Text(`Child组件：`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Button('子组件-增加一级标题')
        .onClick(() => {
          // 子组件内部修改，不会同步到父组件；
          // 当父组件修改后，会覆盖紫组件修改
          this.list.push({
            title: '一级标题888',
            content: '一级内容888'
          })
        })

      ForEach(this.list, (item: ListType) => {
        Column() {
          Text(item.title)
            .backgroundColor('#ffff99')

          if (item.list?.length) {
            ForEach(item.list, (v: ListType) => {
              Column() {
                Text(v.title)
                Text(v.content)
                  .margin({ left: 40 })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 40 })
            })
          } else {
            Text(item.content)
              .margin({ left: 40 })
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}