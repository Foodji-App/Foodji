using Domain.Ingredients;

namespace Domain.Recipes;

public class RecipeIngredient : Ingredient
{
    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
    // TODO - Refactor method after merge
    private RecipeIngredient(
        string description,
        Measurement measurement,
        string name)
            : base(name)
    {
        Description = description;
        Measurement = measurement;
        Name = name;
    }
    
    public static RecipeIngredient Create(
        Measurement measurement,
        string name,
        string description = "",
        IEnumerable<Tag>? tags = null,
        IEnumerable<RecipeSubstitute>? substitutes = null)
    {
        var recipeIngredient = new RecipeIngredient(description, measurement, name);

        if (substitutes != null)
        {
            recipeIngredient.Substitutes = substitutes.ToList();
        }

        if (tags != null)
        {
            recipeIngredient.Tags = tags.ToList();
        }
        
        return recipeIngredient;
    }
}