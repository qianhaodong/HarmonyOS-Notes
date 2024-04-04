@Observed
class Hobby {
  title: string
  desc: string

  constructor(title: string, desc: string) {
    this.title = title;
    this.desc = desc;
  }
}

@Observed
class Person {
  name: string
  age: number
  hobbies: Hobby

  constructor(name: string, age: number, hobbies: Hobby) {
    this.name = name;
    this.age = age;
    this.hobbies = hobbies;
  }
}

@Entry
@Component
struct DemoObjectLink {
  // @Observed、@ObjectLink装饰器用于涉及嵌套对象或者数组的场景中，进行双向数据同步。
  // TODO - 嵌套对象的属性修改
  @State hobbies: Hobby = new Hobby('羽毛球', '羽毛球水平等级1级，高手一个，嘿嘿！');
  @State person: Person = new Person('钱浩东', 27, this.hobbies);

  build() {
    Column({ space: 20 }) {
      Text('父组件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button('修改')
        .onClick(() => {
          this.person.name = this.person.name === 'hello' ? '钱浩东' : 'hello';
          this.person.hobbies.title = '游戏';
        })

      ChileObjectLink({ person: this.person })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(20)
  }
}

@Component
struct ChileObjectLink {
  // @ObjectLink装饰器，不允许本地初始化；必须由父组件传值
  @ObjectLink person: Person;

  build() {
    Column({ space: 10 }) {
      Text('ChileObjectLink组件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 4 }) {
        Text(`姓名：${this.person.name}`)
        Text(`年龄：${this.person.age}`)
          .onClick(() => {
            this.person.age++;
          })
        Column() {
          Text(`爱好：${this.person.hobbies.title}`)
          Text(`介绍：${this.person.hobbies.desc}`)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(4)
        .border({
          width: 1,
          color: Color.Gray
        })
      }
      .width('100%')
      .padding({ left: 20 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}