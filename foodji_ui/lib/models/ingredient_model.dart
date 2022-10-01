class IngredientModel {
  String id;
  String name;
  int qte;

  IngredientModel({
    required this.id,
    required this.name,
    required this.qte,
  });

  // TODO when recieved from server
  //factory IngredientModel.fromJson(Map<String, dynamic> json) {
  //   return IngredientModel();
  // }
}
