namespace Application.Dto;

public record RecipeIngredientDto
{
    public string Description { get; set; }
    
    public MeasurementDto Measurement { get; set; }
}