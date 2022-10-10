namespace Domain.Recipes;

public record RecipeCategory
{
    public string Name { get; private set; }

    public static RecipeCategory Dessert { get; } = new RecipeCategory("Dessert");
    public static RecipeCategory MainCourse { get; } = new RecipeCategory("Plat principal");
    public static RecipeCategory SideDish { get; } = new RecipeCategory("Accompagnement");
    public static RecipeCategory Appetizer { get; } = new RecipeCategory("Entrée");
    public static RecipeCategory Breakfast { get; } = new RecipeCategory("Déjeuner");
    public static RecipeCategory Soup { get; } = new RecipeCategory("Soupe");
    public static RecipeCategory Beverage { get; } = new RecipeCategory("Breuvage");
    public static RecipeCategory Sauce { get; } = new RecipeCategory("Sauce");
    public static RecipeCategory Bread { get; } = new RecipeCategory("Pain");
    public static RecipeCategory Snack { get; } = new RecipeCategory("Collation");
    private RecipeCategory(string name)
    {
        Name = name;
    }

    public static RecipeCategory Create(string name)
    {
        switch (name.ToLower())
        {
            case "dessert":
                return Dessert;
            case "plat principal":
                return MainCourse;
            case "accompagnement":
                return SideDish;
            case "entrée":
            case "entree":
                return Appetizer;
            case "déjeuner":
            case "dejeuner":
                return Breakfast;
            case "soupe":
                return Soup;
            case "breuvage":
                return Beverage;
            case "sauce":
                return Sauce;
            case "pain":
                return Bread;
            case "collation":
                return Snack;
            default:
                throw new DomainException($"Invalid recipe category {name}");
        }
    }
}