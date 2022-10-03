namespace Application.Dto;

public record RecipeDto
{
    public string Name { get; set; }

    public string Category { get; set; }
    
    public string Description { get; set; }
    
    public RecipeDetailsDto Details { get; set; }
    
    public IEnumerable<RecipeIngredientDto> Ingredients { get; set; }
    
    public IEnumerable<RecipeStepDto> Steps { get; set; }
}