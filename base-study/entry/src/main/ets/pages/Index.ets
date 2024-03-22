import { router } from '@kit.ArkUI';

interface DemoType {
  name: string
  pageUrl: string
}

@Entry
@Component
struct Index {
  demoList: DemoType[] = [
    {
      name: '@State装饰器-示例',
      pageUrl: 'pages/DemoState'
    },
    {
      name: '@Prop装饰器-示例',
      pageUrl: 'pages/DemoProp'
    },
    {
      name: '@Link装饰器-示例',
      pageUrl: 'pages/DemoLink'
    },
    {
      name: '@Provide、@Consume装饰器-示例',
      pageUrl: 'pages/DemoProvide'
    },
  ];

  build() {
    Column({ space: 10 }) {
      ForEach(this.demoList, (item: DemoType) => {
        Button(item.name)
          .onClick(() => {
            router.pushUrl({
              url: item.pageUrl
            })
          })
      })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}