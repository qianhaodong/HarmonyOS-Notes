import { router } from '@kit.ArkUI';
import { AppDataType } from '../utils/common';

interface DemoType {
  type: string
  name: string
  pageUrl: string
}

const storage = LocalStorage.getShared();

@Entry(storage)
@Component
struct Index {
  @StorageProp('appData') appData: AppDataType = new AppDataType('', '');
  @LocalStorageProp('message') message: string = '111';

  demoList: DemoType[] = [
    {
      type: 'DemoState',
      name: '@State装饰器-示例',
      pageUrl: 'pages/DemoState'
    },
    {
      type: 'DemoProp',
      name: '@Prop装饰器-示例',
      pageUrl: 'pages/DemoProp'
    },
    {
      type: 'DemoLink',
      name: '@Link装饰器-示例',
      pageUrl: 'pages/DemoLink'
    },
    {
      type: 'DemoProvide',
      name: '@Provide、@Consume装饰器-示例',
      pageUrl: 'pages/DemoProvide'
    },
    {
      type: 'DemoObjectLink',
      name: '@Observed、@ObjectLink装饰器-示例',
      pageUrl: 'pages/DemoObjectLink'
    },
    {
      type: 'DemoLocalStorage',
      name: 'LocalStorage',
      pageUrl: 'pages/DemoLocalStorage'
    },
    {
      type: 'DemoAppStorage',
      name: 'AppStorage',
      pageUrl: 'pages/DemoAppStorage'
    },
    {
      type: 'DemoPersistentStorage',
      name: 'PersistentStorage',
      pageUrl: 'pages/DemoPersistentStorage'
    },
  ];

  build() {
    Column({ space: 10 }) {
      ForEach(this.demoList, (item: DemoType) => {
        Button(item.type === 'DemoLocalStorage' ? `${item.name}-${this.message}` : item.name)
          .onClick(() => {
            router.pushUrl({
              url: item.pageUrl
            })
          })
      })

      Text(`AppStorage: ${this.appData.name}`)
        .fontSize(20)
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}