interface ItemType {
  title: string
}

@Entry
@Component
struct DemoUpRefresh {
  @State message: string = '上拉加载更多列表';
  @State list: ItemType[] = [
    { title: '第1行' },
    { title: '第2行' },
    { title: '第3行' },
    { title: '第4行' },
    { title: '第5行' },
    { title: '第6行' },
    { title: '第7行' },
    { title: '第8行' },
    { title: '第9行' },
  ];
  @State loading: boolean = false;

  listScroller: ListScroller = new ListScroller();

  getData() {
    return new Promise<ItemType[]>((resolve, reject) => {
      setTimeout(() => {
        const arr: ItemType[] = [
          { title: `第${this.list.length + 1}行` },
          { title: `第${this.list.length + 2}行` },
          { title: `第${this.list.length + 3}行` },
          { title: `第${this.list.length + 4}行` },
          { title: `第${this.list.length + 5}行` },
        ];
        resolve(arr);
      }, 1000);
    });
  }

  build() {
    Column() {
      Text(this.message)

      List({
        scroller: this.listScroller
      }) {
        ForEach(this.list, (item: ItemType, index) => {
          ListItem() {
            Text(`第${index + 1}行`)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(120)
          .backgroundColor(index % 2 === 0 ? '#6666ff' : '#ff6666')
        })
      }
      .layoutWeight(1)
      .width('100%')
      .onReachStart(() => {
        console.log('start')
      })
      .onReachEnd(async () => {
        if (this.loading) return;
        console.log('end')
        this.loading = true;

        const result = await this.getData();
        this.list.push(...result);
        this.loading = false;
      })

      if (this.loading) {
        Row() {
          LoadingProgress()
            .width(24)
            .height(24)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(10)
  }
}