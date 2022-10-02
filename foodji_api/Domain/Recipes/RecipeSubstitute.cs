using Domain.Ingredients;

namespace Domain.Recipes;

public class RecipeSubstitute : Substitute
{
    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
    private RecipeSubstitute(
        string description,
        Measurement measurement,
        string name,
        string substitutionPrecisions,
        IEnumerable<Tag> tags)
            : base(
                name,
                tags,
                substitutionPrecisions)
    {
        Description = description;
        Measurement = measurement;
    }

    public static RecipeSubstitute Create(
        Measurement measurement,
        string name,
        string description = "",
        string substitutionPrecisions = "",
        IEnumerable<Tag>? tags = null)
    {
        return new RecipeSubstitute(
            description,
            measurement,
            name,
            substitutionPrecisions,
            tags ?? Enumerable.Empty<Tag>());
    }
}