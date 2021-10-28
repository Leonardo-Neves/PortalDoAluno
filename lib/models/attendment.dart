class AttendmentModel {
  String id = '';
  String name = '';
  String type = '';
  double price = 0;
  String description = '';
  List<String> units = [];
  String accept = '';
  String procedure = '';

  AttendmentModel(
    String id,
    String name,
    String type,
    double price,
    String description,
    List<String> units,
    String accept,
    String procedure,
  ) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.price = price;
    this.description = description;
    this.units = units;
    this.accept = accept;
    this.procedure = procedure;
  }

  attendmentFromJsonToObject(jsonAttendment) {
    this.id = jsonAttendment['_id'];
    this.name = jsonAttendment['name'];
    this.type = jsonAttendment['type'];
    this.price = double.parse(jsonAttendment['price'].toString());
    this.description = jsonAttendment['description'];

    if (jsonAttendment['units'] != null) {
      for (var i = 0; i < jsonAttendment['units'].length; i++) {
        this.units.add(jsonAttendment['units'][i]);
      }
    }
    this.accept =
        jsonAttendment['accept'] != null ? jsonAttendment['accept'] : '';
    this.procedure =
        jsonAttendment['procedure'] != null ? jsonAttendment['procedure'] : '';
  }

  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, type: ${this.type}, price: ${this.price}, description: ${this.description}, units: ${this.units}, accept: ${this.accept}, procedure: ${this.procedure}, }';
  }
}
