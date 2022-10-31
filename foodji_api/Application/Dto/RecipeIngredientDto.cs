namespace Application.Dto;

public record RecipeIngredientDto
{
    public string Name { get; set; } = null!;
    
    public string Description { get; set; } = null!;
    
    public MeasurementDto Measurement { get; set; } = null!;
    
    public IEnumerable<RecipeSubstituteDto> Substitutes { get; set; } = null!;
    
    public IEnumerable<string> Tags { get; set; } = null!;
}
