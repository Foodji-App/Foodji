namespace Domain.Ingredients;

public class IngredientBase
{
    public string Name { get; protected set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }
    
    public IEnumerable<Tag> Tags { get; protected set; }

    protected IngredientBase(string name, IEnumerable<Tag> tags)
    {
        Name = name;
        Tags = tags.ToList();
    }
}