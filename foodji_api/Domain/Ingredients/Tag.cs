namespace Domain.Ingredients;

public record Tag
{
    public string Name { get; private set; }

    public static Tag Vegan { get; } = new("Végétalien");
    public static Tag Vegetarian { get; } = new("Végétarien");
    public static Tag GlutenFree { get; } = new("Sans gluten");
    public static Tag SoyFree { get; } = new("Sans soya");
    public static Tag NutFree { get; } = new("Sans noix");
    public static Tag PeanutFree { get; } = new("Sans arachides");
    public static Tag LactoseFree { get; } = new("Sans lactose");
    public static Tag MilkFree { get; } = new("Sans lait");
    public static Tag WheatFree { get; } = new("Sans blé");
    public static Tag SeafoodFree { get; } = new("Sans fruits de mer");
    public static Tag Halal { get; } = new("Halal");
    public static Tag Kosher { get; } = new("Casher");

    private Tag(string name)
    {
        Name = name;
    }

    public static Tag Create(string name)
    {
        switch (name.ToLower())
        {
            case "végétalien":
            case "vegetalien":
            case "vegan":
            case "vegane":
                return Vegan;
            case "végétarien":
            case "vegetarien":
                return Vegetarian;
            case "sans gluten":
                return GlutenFree;
            case "sans soya":
                return SoyFree;
            case "sans noix":
                return NutFree;
            case "sans arachides":
                return PeanutFree;
            case "sans lactose":
                return LactoseFree;
            case "sans lait":
                return MilkFree;
            case "sans blé":
            case "sans ble":
                return WheatFree;
            case "sans fruits de mer":
                return SeafoodFree;
            case "halal":
                return Halal;
            case "casher":
            case "kosher":
                return Kosher;
            default:
                return new Tag(name);
        }
    }
}