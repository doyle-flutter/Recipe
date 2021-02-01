class Store {
  static Store _instance;

  static Future<Store> getInstance() async {
    if (Store._instance == null) {
      Store._instance = new Store();
    }
    return Store._instance;
  }

  dynamic _data;
  dynamic get data => _data;
  set data(newData) => _data = newData;
}
