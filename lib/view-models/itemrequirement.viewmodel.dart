class ItemRequirementViewModel {
  String label = '';
  DateTime createdDate = new DateTime.now();

  ItemRequirementViewModel(
    String label,
  ) {
    this.label = label;
  }

  String toString() {
    return '{ id: ${this.label}, protocolNumber: ${this.createdDate},  }';
  }
}
