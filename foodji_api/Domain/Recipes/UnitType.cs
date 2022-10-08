namespace Domain.Recipes;

public record UnitType
{        
    // TODO: Determine what unitType should be by default
    
    public string Name { get; private set; }
    
    public static UnitType Unit = new UnitType("unité");
    public static UnitType Millilitre = new UnitType("ml");
    public static UnitType Gram = new UnitType("g");
    public static UnitType Cup = new UnitType("tasse");
    public static UnitType TableSpoon = new UnitType("c. à table");
    public static UnitType TeaSpoon = new UnitType("c. à thé");
    public static UnitType FluidOunce = new UnitType("fl oz");
    public static UnitType Ounce = new UnitType("oz");
    public static UnitType Pound = new UnitType("lb");

    private UnitType(string name)
    {
        Name = name;
    }

    public static UnitType Create(string name)
    {
        // TODO reconcile FE and BE on translation / uniformity here
        switch (name.ToLower())
        {
            // As in "one banana" - avoid adding additional arbitrary measures as much as possible, they are not uniform.
            // "A can" can be entirely different from one area to another, from a year to another (e.g. shrinkflation), etc.
            // TODO - have a tooltip to discourage such use on the front end whenever possible
            case "unite":
            case "unité":
                return Unit;
            case "ml":
            case "millilitre":
                return Millilitre;
            case "g":
            case "gramme":
                return Gram;
            case "t.":
            case "tasse":
                return Cup;
            case "c. à soupe":
            case "c. a soupe":
                return TableSpoon;
            case "c. à thé":
            case "c. a the":
                return TeaSpoon;
            default:
                throw new DomainException($"Unrecognized unit type {name}");
        }
    }
    

}