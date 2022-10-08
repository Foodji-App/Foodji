namespace Domain.Recipes;

public record UnitType
{        
    // TODO: Determine what unitType should be by default
    
    public string Name { get; private set; }
    
    public static UnitType Gram = new UnitType("Gram");
    public static UnitType Millilitre = new UnitType("Millilitre");
    public static UnitType Unit = new UnitType("Unit");
    public static UnitType Cup = new UnitType("Cup");
    public static UnitType TeaSpoon = new UnitType("TeaSpoon");
    public static UnitType TableSpoon = new UnitType("TableSpoon");
    public static UnitType FluidOunce = new UnitType("FluidOunce");
    public static UnitType Ounce = new UnitType("Ounce");
    public static UnitType Pound = new UnitType("Pound");

    public UnitType(string name)
    {
        Name = name;
    }
    
    // As in "one banana" - avoid adding additional arbitrary measures as much as possible, they are not uniform.
    // "A can" can be entirely different from one area to another, from a year to another (e.g. shrinkflation), etc.
    // TODO - have a tooltip to discourage such use on the front end whenever possible
}