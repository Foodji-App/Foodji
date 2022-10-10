namespace Domain.Ingredients;

public class Substitute : IngredientBase
{
    public string SubstitutionPrecisions { get; protected set; } = String.Empty;

    protected Substitute(string name)
        : base(name)
    {
    }

    public static Substitute Create(string name, IEnumerable<Tag> tags, string substitutionPrecisions)
    {
        return new Substitute(name)
        {
            Tags = tags.ToList(),
            SubstitutionPrecisions = substitutionPrecisions
        };
    }
}