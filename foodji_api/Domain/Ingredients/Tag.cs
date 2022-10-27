namespace Domain.Ingredients;

public record Tag
{
    public string Name { get; private set; }

    public static Tag Vegan { get; } = new("vegan");
    public static Tag Vegetarian { get; } = new("vegetarian");
    public static Tag GlutenFree { get; } = new("glutenFreen");
    public static Tag SoyFree { get; } = new("soyFree");
    public static Tag EggFree { get; } = new("eggFree");
    public static Tag NutFree { get; } = new("nutFree");
    public static Tag PeanutFree { get; } = new("peanutFree");
    public static Tag LactoseFree { get; } = new("lactoseFree");
    public static Tag MilkFree { get; } = new("milkFree");
    public static Tag WheatFree { get; } = new("wheatFree");
    public static Tag SeafoodFree { get; } = new("seafoodFree");
    public static Tag Halal { get; } = new("halal");
    public static Tag Kosher { get; } = new("kosher");

    private Tag(string name)
    {
        Name = name;
    }

    public static Tag Create(string name)
    {
        switch (name.ToLower())
        {
            case "vegan":
                return Vegan;
            case "vegetarian":
                return Vegetarian;
            case "glutenFree":
                return GlutenFree;
            case "soyFree":
                return SoyFree;
            case "nutFree":
                return NutFree;
            case "eggFree":
                return EggFree;
            case "peanutFree":
                return PeanutFree;
            case "lactoseFree":
                return LactoseFree;
            case "milkFree":
                return MilkFree;
            case "wheatFree":
                return WheatFree;
            case "seafoodFree":
                return SeafoodFree;
            case "halal":
                return Halal;
            case "kosher":
                return Kosher;
            default:
                return new Tag(name);
        }
    }
}