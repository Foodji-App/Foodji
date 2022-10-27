namespace Domain.Recipes;

public record RecipeCategory
{
    public string Name { get; private set; }

    public static RecipeCategory MainCourse { get; } = new RecipeCategory("mainCourse");
    public static RecipeCategory SideDish { get; } = new RecipeCategory("sideDish");
    public static RecipeCategory Appetizer { get; } = new RecipeCategory("appetizer");
    public static RecipeCategory Dessert { get; } = new RecipeCategory("dessert");
    public static RecipeCategory Lunch { get; } = new RecipeCategory("lunch");
    public static RecipeCategory Breakfast { get; } = new RecipeCategory("breakfast");
    public static RecipeCategory Beverage { get; } = new RecipeCategory("beverage");
    public static RecipeCategory Soup { get; } = new RecipeCategory("soup");
    public static RecipeCategory Sauce { get; } = new RecipeCategory("sauce");
    public static RecipeCategory Bread { get; } = new RecipeCategory("bread");
    public static RecipeCategory Snack { get; } = new RecipeCategory("snack");
    private RecipeCategory(string name)
    {
        Name = name;
    }

    public static RecipeCategory Create(string name)
    {
        switch (name)
        {
            case "dessert":
                return Dessert;
            case "mainCourse":
                return MainCourse;
            case "sideDish":
                return SideDish;
            case "appetizer":
                return Appetizer;
            case "lunch":
                return Lunch;
            case "breakfast":
                return Breakfast;
            case "soup":
                return Soup;
            case "beverage":
                return Beverage;
            case "sauce":
                return Sauce;
            case "bread":
                return Bread;
            case "snack":
                return Snack;
            default:
                throw new DomainException($"Invalid recipe category {name}");
        }
    }
}