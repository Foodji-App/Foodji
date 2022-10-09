namespace Application.Dto;

public record RecipeStepDto
{
    public int Index { get; set; }

    public string Content { get; set; } = null!;
}