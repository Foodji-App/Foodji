namespace Domain.Ingredients;

public class IngredientBase
{
    public string Name { get; protected set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }

    public IEnumerable<Tag> Tags { get; protected set; } = new List<Tag>();

    protected IngredientBase(string name)
    {
        Name = name;
    }
}