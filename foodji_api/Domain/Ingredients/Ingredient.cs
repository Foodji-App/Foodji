namespace Domain.Ingredients;

public class Ingredient
{
    public string Name { get; private set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }
    
    public IEnumerable<Tag> Tags { get; private set; }
    
    public IEnumerable<Ingredient> Substitutes { get; set; }
}