class AppRoutes {

  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static String baseUrl = 'https://localhost:7272';
  static String recipes = '/recipes';
  static String recipeDetail = '/recipeDetail';
  static String recipeAdd = '/recipeAdd';
  static String recipeEdit = '/recipeEdit';
  static String recipeDelete = '/recipeDelete';
}