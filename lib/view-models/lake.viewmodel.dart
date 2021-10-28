// Model
import 'package:projeto/models/lake.model.dart';

class LakeViewModel {
  String id = '';
  String name = '';
  int lake = 0;

  LakeViewModel(
    String id,
    String name,
    int lake,
  ) {
    this.id = id;
    this.name = name;
    this.lake = lake;
  }

  lakeFromJsonToObject(jsonLake) {
    this.id = jsonLake['_id'];
    this.name = jsonLake['name'];
    this.lake = int.parse(jsonLake['lake']);
  }

  lakeFromLakeModelToLakeViewModel(LakeModel lakeModel) {
    this.id = lakeModel.id;
    this.name = lakeModel.name;
    this.lake = lakeModel.lake;
  }

  chooseMounth(LakeViewModel lakeModel) {
    switch (lakeModel.name) {
      case 'Janeiro':
        return 'JAN';
      case 'Fevereiro':
        return 'FEV';
      case 'Março':
        return 'MAR';
      case 'Abril':
        return 'ABR';
      case 'Maio':
        return 'MAI';
      case 'Junho':
        return 'JUN';
      case 'Julho':
        return 'JUL';
      case 'Agosto':
        return 'AGO';
      case 'Setembro':
        return 'SET';
      case 'Outubro':
        return 'OUT';
      case 'Novembro':
        return 'NOV';
      case 'Dezembro':
        return 'DEZ';
    }
  }

  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, lake: ${this.lake},  }';
  }
}
