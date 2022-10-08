import 'package:faker/faker.dart';

class IngredientModel {
  String name;
  int qte;

  IngredientModel({
    required this.name,
    required this.qte,
  });

  static IngredientModel getSample() {
    var faker = Faker();

    return IngredientModel(
        name: faker.food.cuisine(), qte: faker.randomGenerator.integer(10));
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
