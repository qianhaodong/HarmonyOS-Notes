class Model {
  public value: string;

  constructor(value: string) {
    this.value = value;
  }
}

@Entry
@Component
struct Parent {
  /* 管理组件拥有的状态
   * @State
   * @Prop：@Prop装饰的变量可以和父组件建立单向同步关系，@Prop装饰的变量是可变的，但修改不会同步回父组件。
   * @Link：@Link装饰的变量和父组件构建双向同步关系的状态变量，父组件会接受来自@Link装饰的变量的修改的同步，父组件的更新也会同步给@Link装饰的变量。
   * @Provide/@Consume
   * @Observed：@Observed装饰class，需要观察多层嵌套场景的class需要被@Observed装饰。
   * @ObjectLink
   * */

  /* 管理应用拥有的状态
   * @StorageProp
   * @StorageLink
   * @LocalStorageProp
   * @LocalStorageLink
   * */
  @State message: Model = new Model('Hello World');
  @State inputValue: string = '';

  build() {
    Row() {
      Column({ space: 20 }) {
        Button(`parent: ${this.message.value}`)
          .onClick(() => {
            this.message.value = this.message.value === 'changed value' ? 'hello' : 'changed value';
          })

        // child({ title: new Model('hello'), count: 1 })
        child({ message: this.message, count: 3 })

        // $$语法：双向绑定
        Text(`value: ${this.inputValue}`)
        TextInput({ text: $$this.inputValue, placeholder: '请输入' })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct child {
  @State title: Model = new Model('ArkTS');
  @State count: number = 0;
  private total: number = 2;

  // 当且仅当@Prop有初始化时，从父组件向子组件传递@Prop的参数才是可选的
  @Prop @Watch('messageChanged') message: Model = new Model('child message');
  @State messageChangeTips: string = '';

  messageChanged(propName: string) {
    this.messageChangeTips = '改变了';
    console.log('messageChanged: ', propName);
  }

  build() {
    Column({ space: 10 }) {
      // Text(`title: ${this.title.value}`)
      //   .fontSize(20)

      Button('change message value')
        .onClick((): void => {
          this.message.value = this.message.value === 'ArkTS' ? 'ArkUI' : 'ArkTS';
        })

      Text(`message: ${this.message.value}`)
        .fontSize(20)

      // Button(`change number ${this.count}`)
      //   .onClick(() => {
      //     this.count += this.total;
      //   })

      Text(`changeMessage: ${this.messageChangeTips}`)
    }
  }
}