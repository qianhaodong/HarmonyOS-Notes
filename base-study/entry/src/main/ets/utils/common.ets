class PersonLocal {
  name: string
  age: number

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}

// Record 泛型，常用于对象字面量初始化值的场景
const user: Record<string, PersonLocal | string> = {
  'user': new PersonLocal('西门吹雪', 18),
  'message': '全局localStorage'
}

const storage = new LocalStorage(user);

export { storage, PersonLocal }