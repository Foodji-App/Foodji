class RecipeModel {
  String name;
  String img;
  int stars;
  String description;

  RecipeModel(
      {required this.name,
      required this.img,
      required this.stars,
      required this.description});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        name: json["name"],
        img: json["img"],
        stars: json["stars"],
        description: json["description"]);
  }
}
