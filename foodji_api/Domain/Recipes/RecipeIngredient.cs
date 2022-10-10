using Domain.Ingredients;

namespace Domain.Recipes;

public class RecipeIngredient : Ingredient
{
    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
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
        string description,
        IEnumerable<Tag> tags,
        IEnumerable<RecipeSubstitute> substitutes)
    {
        var recipeIngredient = new RecipeIngredient(description, measurement, name)
        {
            Substitutes = substitutes.ToList(),
            Tags = tags.ToList()
        };

        return recipeIngredient;
    }
}