namespace Application.Dto;

public record RecipeDetailsDto
{
    public int CookingTime { get; set; } = 0;
    
    public int PreparationTime { get; set; } = 0;
    
    public int RestingTime { get; set; } = 0;
    
    public int Serves { get; set; } = 0;
}