namespace Application.Dto;

public class RecipeAccessRightsDto
{
    // Used exclusively for authorization purposes
    // This is a structure so we can eventually extend it to add things such as public read access,
    // or different edit rights structures (co-author, editors?)
    public string AuthorId { get; init; }
}