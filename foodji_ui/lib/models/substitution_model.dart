import 'package:faker/faker.dart';
import 'package:foodji_ui/models/tags_enum.dart';

class SubstitutionModel {
  String name;
  int qte;
  List<String> tags;

  SubstitutionModel(
      {required this.name, required this.qte, required this.tags});

  static SubstitutionModel getSample() {
    var faker = Faker();

    return SubstitutionModel(
        name: faker.food.cuisine(),
        qte: faker.randomGenerator.integer(10),
        tags: {
          faker.randomGenerator.element(Tags.values).name,
          faker.randomGenerator.element(Tags.values).name
        }.toList());
  }

  static List<SubstitutionModel> getSamples(int amount) {
    var samples = <SubstitutionModel>[];

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
