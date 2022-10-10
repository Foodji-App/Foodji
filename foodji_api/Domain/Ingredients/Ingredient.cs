namespace Domain.Ingredients;

public class Ingredient : IngredientBase
{
    public IEnumerable<Substitute> Substitutes { get; set; } = new List<Substitute>();

    protected Ingredient(string name)
        : base (name)
    {
    }
    
    public static Ingredient Create(
        string name,
        IEnumerable<Tag> tags,
        IEnumerable<Substitute> substitutes)
    {
        var ingredient = new Ingredient(name) 
        { 
            Tags = tags.ToList(), 
            Substitutes = substitutes.ToList() 
        };

        return ingredient;
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