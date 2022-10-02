using Domain.Ingredients;

namespace Domain.Recipes;

public class RecipeIngredient
{
    // Recipe-specific fields
    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
    
    // Generic ingredient fields
    public string Name { get; protected set; }

    public IEnumerable<Tag> Tags { get; protected set; }

    protected RecipeIngredient(
        string description,
        Measurement measurement,
        string name,
        IEnumerable<Tag> tags)
    {
        Description = description;
        Measurement = measurement;
        Name = name;
        Tags = tags.ToList();
    }
    static RecipeIngredient Create(
        Measurement measurement,
        string name,
        string description = "",
        IEnumerable<Tag>? tags = null)
    {
        return new RecipeIngredient(
            description,
            measurement,
            name,
            tags ?? Enumerable.Empty<Tag>());
    }
}