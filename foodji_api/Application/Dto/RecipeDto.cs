namespace Application.Dto;

public record RecipeDto
{
    // We don't actually use this field on our end, but it is easier for now
    // to leave it there than to have the FE not send it
    public string? Id { get; set; }
    
    public string Name { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public string Category { get; set; } = null!;
    
    public string Description { get; set; } = null!;
    
    public RecipeDetailsDto Details { get; set; } = null!;
    
    public IEnumerable<RecipeIngredientDto> Ingredients { get; set; } = null!;
    
    public IEnumerable<string> Steps { get; set; } = null!;
    
    public Uri ImageUri { get; set; } = null!;
    
    public string? Author { get; set; }
}