namespace Application.Dto;

public record RecipeDto
{
    public string Name { get; set; } = null!;

    public string Category { get; set; } = null!;
    
    public string Description { get; set; } = null!;
    
    public RecipeDetailsDto Details { get; set; } = null!;
    
    public IEnumerable<RecipeIngredientDto> Ingredients { get; set; } = null!;
    
    public IEnumerable<RecipeStepDto> Steps { get; set; } = null!;
}