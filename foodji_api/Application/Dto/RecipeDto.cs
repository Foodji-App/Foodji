namespace Application.Dto;

public record RecipeDto
{
    public string? Id { get; set; }
    
    public string Name { get; set; } = null!;

    public string Category { get; set; } = null!;
    
    public string Description { get; set; } = null!;
    
    public RecipeDetailsDto Details { get; set; } = null!;
    
    public IEnumerable<RecipeIngredientDto> RecipeIngredients { get; set; } = null!;
    
    public IEnumerable<string> Steps { get; set; } = null!;
    
    public Uri ImageUri { get; set; } = null!;
}