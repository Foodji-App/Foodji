using FoodjiApi.DbRepresentations.Ingredients;

namespace FoodjiApi.DbRepresentations.Recipes;

public class RecipeIngredient
{
    // Recipe-specific fields
    public Measurement Measurement { get; private set; }
    
    public string Description { get; private set; }
    
    // TODO - Should there be a safeguard against nested substitutions? (Different type, validation...)
    public IEnumerable<RecipeIngredient> Substitutions { get; private set; }
    
    // Generic ingredient fields
    public string Name { get; private set; }

    public IEnumerable<Tags> Tags { get; private set; }
}