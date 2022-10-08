namespace Domain.Recipes;

public class Measurement
{
    public string AlternativeText { get; private set; }
    
    public decimal Value { get; private set; }
    
    public UnitType UnitType { get; private set; }
    
    private Measurement(decimal value, string alternativeText, UnitType unitType)
    {
        AlternativeText = alternativeText;
        Value = value;
        UnitType = unitType;
    }
    
    public static Measurement Create(UnitType unitType, string alternativeText = "", decimal value = 0)
    {
        if (value == 0 && String.IsNullOrEmpty(alternativeText))
        {
            throw new DomainException("Measurement must have a value or alternative text");
        }
        
        return new Measurement(value, alternativeText, unitType);
    }
}