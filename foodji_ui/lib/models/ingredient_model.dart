import 'package:faker/faker.dart';
import 'package:foodji_ui/models/tags_enum.dart';
import 'package:foodji_ui/models/substitution_model.dart';

class IngredientModel {
  String name;
  int qte;
  List<String> tags;
  List<SubstitutionModel> substitutions;

  IngredientModel(
      {required this.name,
      required this.qte,
      required this.tags,
      required this.substitutions});

  static IngredientModel getSample() {
    var faker = Faker();

    return IngredientModel(
        name: faker.food.cuisine(),
        qte: faker.randomGenerator.integer(10),
        tags: {
          faker.randomGenerator.element(Tags.values).name,
          faker.randomGenerator.element(Tags.values).name
        }.toList(),
        substitutions: SubstitutionModel.getSamples(random.integer(2, min: 0)));
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
