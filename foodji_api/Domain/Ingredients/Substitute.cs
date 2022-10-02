namespace Domain.Ingredients;

public class Substitute : IngredientBase
{
    public string SubstitutionPrecisions { get; private set; }

    protected Substitute(string name, IEnumerable<Tag> tags, string substitutionPrecisions)
        : base(name, tags)
    {
        SubstitutionPrecisions = substitutionPrecisions;
    }

    static Substitute Create(string name, IEnumerable<Tag>? tags = null, string substitutionPrecisions = "")
    {
        return new Substitute(name, tags ?? Enumerable.Empty<Tag>(), substitutionPrecisions);
    }
}