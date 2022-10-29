namespace Application.Dto;

public class UserDataDto
{
    public string Id { get; set; } = null!;

    public IEnumerable<string> Recipes { get; set; } = null!;
}