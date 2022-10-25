import 'package:faker/faker.dart';

class IngredientModel {
  String name;
  // String? description; // TODO : implement
  int amount;
  String unit;
  // List<String> tags; // TODO : implement
  // List<IngredientModel> substitutes; // TODO : implement

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

  static deepCopy(List<IngredientModel> ingredients) {
    var copy = <IngredientModel>[];

    for (var ingredient in ingredients) {
      copy.add(IngredientModel(
          name: ingredient.name,
          amount: ingredient.amount,
          unit: ingredient.unit));
    }
    return copy;
  }

  bool equals(IngredientModel other) {
    return name == other.name && amount == other.amount && unit == other.unit;
  }

  // TODO when recieved from server
  //factory IngredientModel.fromJson(Map<String, dynamic> json) {
  //   return IngredientModel();
  // }
}
