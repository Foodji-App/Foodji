namespace Domain.Recipes;

public class Measurement
{
    public string AlternativeText { get; private set; }
    
    public decimal Value { get; private set; }
    
    public UnitType UnitType { get; private set; }
    
    private Measurement(decimal value, UnitType unitType, string alternativeText)
    {
        Value = value;
        UnitType = unitType;
        AlternativeText = alternativeText;
    }
    
    public static Measurement Create(decimal value, UnitType unitType, string alternativeText)
    {
        if (value == 0 && String.IsNullOrEmpty(alternativeText))
        {
            throw new DomainException("Measurement must have a value or alternative text");
        }
        
        return new Measurement(value, unitType, alternativeText);
    }
}