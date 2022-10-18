namespace Application.Dto;

public record RecipeStepDto
{
    public int Index { get; set; } = 0;

    public string Content { get; set; } = null!;
}