using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Recipes;

public class Recipe
{
    [BsonId]
    public ObjectId Id { get; private set; }
    
    public string Name { get; private set; }

    public DateTime CreatedAt { get; private set; }
    
    // TODO - single or list of categories?
    // For now, let's pretend a recipe can only be in one category and we'll create a list if need be.
    public RecipeCategory Category { get; private set; }
    
    public string Description { get; private set; }
    
    public RecipeDetails Details { get; private set; }
    
    public IEnumerable<RecipeIngredient> Ingredients { get; private set; }
    
    public IEnumerable<RecipeStep> Steps { get; private set; }
    
    private Recipe(
        string name, 
        DateTime createdAt, 
        RecipeCategory category, 
        string description, 
        RecipeDetails details, 
        IEnumerable<RecipeIngredient> ingredients, 
        IEnumerable<RecipeStep> steps)
    {
        Name = name;
        CreatedAt = createdAt;
        Category = category;
        Details = details;
        Description = description;
        Ingredients = ingredients.ToList();
        Steps = steps.ToList();
    }
    public static Recipe Create(
        string name, 
        RecipeCategory category, 
        string description, 
        RecipeDetails details, 
        IEnumerable<RecipeIngredient> ingredients, 
        IEnumerable<RecipeStep> steps)
    {
        return new Recipe(name, DateTime.Now, category, description, details, ingredients, steps);
    }
    
}
