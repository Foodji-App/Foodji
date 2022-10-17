import 'package:faker/faker.dart';

class IngredientModel {
  String name;
  int amount;
  String unit;

  IngredientModel(
      {required this.name, required this.amount, required this.unit});

  static IngredientModel newIngredientModel() {
    return IngredientModel(name: '', amount: 0, unit: '');
  }

  static IngredientModel getSample() {
    var faker = Faker();

    return IngredientModel(
        name: faker.food.cuisine(),
        amount: faker.randomGenerator.integer(10),
        unit: 'unit(s)');
  }

  static List<IngredientModel> getSamples(int amount) {
    var samples = <IngredientModel>[];

    for (var i = 0; i < amount; i++) {
      samples.add(getSample());
    }
    return samples;
  }

  // TODO when recieved from server
  //factory IngredientModel.fromJson(Map<String, dynamic> json) {
  //   return IngredientModel();
  // }
}
