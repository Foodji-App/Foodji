namespace Application.Dto;

public record RecipeSubstituteDto
{
    public string Name { get; set; } = null!;
    
    public string Description { get; set; } = null!;
    
    public string SubstitutionPrecision { get; set; } = null!;
    
    public MeasurementDto Measurement { get; set; } = null!;
    
    public IEnumerable<string> Tags { get; set; } = null!;
}