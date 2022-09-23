namespace Api.DbRepresentations.Recipes;

public class Measurement
{
    public decimal Value { get; private set; }
    
    public UnitType UnitType { get; private set; }
    
    public string AlternativeText { get; private set; }
}