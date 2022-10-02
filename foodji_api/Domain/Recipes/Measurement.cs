namespace Domain.Recipes;

public class Measurement
{
    public decimal Value { get; private set; }
    
    public UnitType UnitType { get; private set; }
    
    public string AlternativeText { get; private set; }
    
    private Measurement(decimal value, UnitType unitType, string alternativeText)
    {
        Value = value;
        UnitType = unitType;
        AlternativeText = alternativeText;
    }
    
    static Measurement Create(decimal value, UnitType unitType, string alternativeText = "")
    {
        // TODO - Implement validation, (value && unitType) || alternativeText
        
        throw new Exception("Not implemented, should be a Domain Exception");
        
        return new Measurement(value, unitType, alternativeText);
    }
}