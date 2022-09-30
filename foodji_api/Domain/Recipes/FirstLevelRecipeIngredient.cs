using Domain.Ingredients;

namespace Domain.Recipes;

public class FirstLevelRecipeIngredient : RecipeIngredient
{
    public IEnumerable<RecipeIngredient> Substitutions { get; private set; }

    protected FirstLevelRecipeIngredient(
        string name,
        Measurement measurement,
        string description,
        IEnumerable<Tag> tags,
        IEnumerable<RecipeIngredient> substitutions)
            : base(
                name, 
                measurement, 
                description, 
                tags)
    {
        Name = name;
        Measurement = measurement;
        Description = description;
        Tags = tags.ToList();
        Substitutions = substitutions.ToList();
    }
    
    static FirstLevelRecipeIngredient Create(
        string name,
        Measurement measurement,
        string description = "",
        IEnumerable<Tag>? tags = null,
        IEnumerable<RecipeIngredient>? substitutions = null)
    {
        return new FirstLevelRecipeIngredient(
            name,
            measurement,
            description,
            tags ?? Enumerable.Empty<Tag>(),
            substitutions ?? Enumerable.Empty<RecipeIngredient>());
    }
}