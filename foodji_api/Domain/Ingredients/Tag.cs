namespace Domain.Ingredients;

public record Tag
{
    public string Name { get; private set; }

    public static Tag Vegan { get; } = new("Vegan");
    public static Tag Vegetarian { get; } = new("Vegetarian");
    public static Tag GlutenFree { get; } = new("GlutenFree");
    public static Tag SoyFree { get; } = new("SoyFree");
    public static Tag NutFree { get; } = new("NutFree");
    public static Tag PeanutFree { get; } = new("PeanutFree");
    public static Tag LactoseFree { get; } = new("LactoseFree");
    public static Tag MilkFree { get; } = new("MilkFree");
    public static Tag WheatFree { get; } = new("WheatFree");
    public static Tag SeafoodFree { get; } = new("SeafoodFree");
    public static Tag Halal { get; } = new("Halal");
    public static Tag Kosher { get; } = new("Kosher");

    private Tag(string name)
    {
        Name = name;
    }

    public static Tag Create(string name)
    {
        // TODO: Validate name like in RecipeCategory
        // TODO: Translate the tags to French
        
        return new Tag(name.ToLower());
    }
}