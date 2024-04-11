class PersonLocal {
  name: string
  age: number

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}

class AppDataType {
  name: string
  message: string

  constructor(name: string, message: string) {
    this.name = name;
    this.message = message;
  }
}

// Record 泛型，常用于对象字面量初始化值的场景
const user: Record<string, PersonLocal | string> = {
  'user': new PersonLocal('西门吹雪', 18),
  'message': '全局localStorage'
}

// LocalStorage存储，保存在内存中；应用进程杀掉后，则数据销毁。
const storage = new LocalStorage(user);

export {
  storage,
  PersonLocal,
  AppDataType,
}