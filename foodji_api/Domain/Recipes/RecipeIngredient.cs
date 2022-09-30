using Domain.Ingredients;

namespace Domain.Recipes;

public class RecipeIngredient
{
    // Recipe-specific fields
    public Measurement Measurement { get; private set; }
    
    public string Description { get; private set; }
    
    // TODO - Should there be a safeguard against nested substitutions? (Different type, validation...)
    public IEnumerable<RecipeIngredient> Substitutions { get; private set; }
    
    // Generic ingredient fields
    public string Name { get; private set; }

    public IEnumerable<Tag> Tags { get; private set; }

    private RecipeIngredient(
        string name,
        Measurement measurement,
        string description,
        IEnumerable<RecipeIngredient> substitutions,
        IEnumerable<Tag> tags)
    {
        Name = name;
        Measurement = measurement;
        Description = description;
        Substitutions = substitutions.ToList();
        Tags = tags.ToList();
    }
    static RecipeIngredient Create(
        string name,
        Measurement measurement,
        string description = "",
        IEnumerable<RecipeIngredient>? substitutions = null,
        IEnumerable<Tag>? tags = null)
    {
        return new RecipeIngredient(
            name,
            measurement,
            description,
            substitutions ?? Enumerable.Empty<RecipeIngredient>(),
            tags ?? Enumerable.Empty<Tag>());
    }
    
}