namespace Domain.Ingredients;

public class Ingredient : IngredientBase
{
    public IEnumerable<Substitute> Substitutes { get; set; }

    protected Ingredient(string name, IEnumerable<Tag> tags, IEnumerable<Substitute> substitutes)
        : base (name, tags)
    {
        Substitutes = substitutes.ToList();
    }
    
    public Ingredient Create(
        string name,
        IEnumerable<Tag>? tags = null,
        IEnumerable<Substitute>? substitutes = null)
    {
        return new Ingredient(name, tags ?? Enumerable.Empty<Tag>(), substitutes ?? Enumerable.Empty<Substitute>());
    }

    public void AddSubstitute(Substitute substitute)
    {
        if (Substitutes.Any(x => x.Name == substitute.Name))
        {
            throw new DomainException("Cannot add a substitute with the same name as another substitute.");
        }

        var newSubstitutes = Substitutes.ToList();
        newSubstitutes.Add(substitute);

        Substitutes = newSubstitutes;
    }
}