namespace Domain.Ingredients;

public class Substitute : IngredientBase
{
    public string SubstitutionPrecisions { get; private set; }

    private Substitute(string name)
        : base(name)
    {
    }

    public static Substitute Create(string name, IEnumerable<Tag>? tags = null, string substitutionPrecisions = "")
    {
        return new Substitute(name)
        {
            Tags = tags ?? Enumerable.Empty<Tag>(),
            SubstitutionPrecisions = substitutionPrecisions
        };
    }
}