class LakeModel {
  String id = '';
  String name = '';
  int lake = 0;

  LakeModel(
    String id,
    String name,
    int lake,
  ) {
    this.id = id;
    this.name = name;
    this.lake = lake;
  }

  gradesFromJsonToObject(jsonLake) {
    this.id = jsonLake['_id'];
    this.name = jsonLake['name'];
    this.lake = jsonLake['lake'];
  }

  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, lake: ${this.lake},  }';
  }
}
