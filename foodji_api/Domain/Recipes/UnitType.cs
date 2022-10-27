namespace Domain.Recipes;

public record UnitType
{        
    // TODO: Determine what unitType should be by default
    
    public string Name { get; private set; }
    
    public static UnitType Unit = new UnitType("unit");
    public static UnitType Millilitre = new UnitType("millilitre");
    public static UnitType Gram = new UnitType("gram");
    public static UnitType Cup = new UnitType("cup");
    public static UnitType Tablespoon = new UnitType("tablespoon");
    public static UnitType Teaspoon = new UnitType("teaspoon");
    public static UnitType FluidOunce = new UnitType("fluidOunce");
    public static UnitType Ounce = new UnitType("ounce");
    public static UnitType Pound = new UnitType("pound");

    private UnitType(string name)
    {
        Name = name;
    }

    public static UnitType Create(string name)
    {
        switch (name.ToLower())
        {
            // As in "one banana" - avoid adding additional arbitrary measures as much as possible, they are not uniform.
            // "A can" can be entirely different from one area to another, from a year to another (e.g. shrinkflation), etc.
            // TODO - have a tooltip to discourage such use on the front end whenever possible
            case "unit":
                return Unit;
            case "millilitre":
                return Millilitre;
            case "gram":
                return Gram;
            case "cup":
                return Cup;
            case "tablespoon":
                return Tablespoon;
            case "teaspoon":
                return Teaspoon;
            case "fluidOunce":
                return FluidOunce;
            case "ounce":
                return Ounce;
            case "pound":
                return Pound;
            default:
                throw new DomainException($"Unrecognized unit type {name}");
        }
    }
    

}