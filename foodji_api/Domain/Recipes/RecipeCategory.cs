namespace Domain.Recipes;

public record RecipeCategory
{
    public string Name { get; private set; }

    public static RecipeCategory Dessert { get; } = new RecipeCategory("Dessert");
    public static RecipeCategory MainCourse { get; } = new RecipeCategory("Main Course");
    public static RecipeCategory SideDish { get; } = new RecipeCategory("Side Dish");
    public static RecipeCategory Appetizer { get; } = new RecipeCategory("Appetizer");
    public static RecipeCategory Breakfast { get; } = new RecipeCategory("Breakfast");
    public static RecipeCategory Soup { get; } = new RecipeCategory("Soup");
    public static RecipeCategory Beverage { get; } = new RecipeCategory("Beverage");
    public static RecipeCategory Sauce { get; } = new RecipeCategory("Sauce");
    public static RecipeCategory Bread { get; } = new RecipeCategory("Bread");
    public static RecipeCategory Snack { get; } = new RecipeCategory("Snack");
    private RecipeCategory(string name)
    {
        Name = name;
    }
}