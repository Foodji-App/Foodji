namespace Api.DbRepresentations.Ingredients;

public class Ingredient
{
    public string Name { get; private set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }
    
    public IEnumerable<Tags> Tags { get; private set; }
    
    public IEnumerable<Ingredient> Substitutes { get; set; }
}