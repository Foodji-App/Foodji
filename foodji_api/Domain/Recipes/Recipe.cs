using System.Diagnostics.Tracing;
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
    
    public IEnumerable<RecipeIngredient> RecipeIngredients { get; private set; }
    
    public IEnumerable<string> Steps { get; private set; }
    
    public Uri ImageUri { get; private set; }
    
    private Recipe(
        string name, 
        DateTime createdAt, 
        RecipeCategory category, 
        string description, 
        RecipeDetails details, 
        IEnumerable<RecipeIngredient> recipeIngredients, 
        IEnumerable<string> steps,
        Uri imageUri)
    {
        Name = name;
        CreatedAt = createdAt;
        Category = category;
        Details = details;
        Description = description;
        RecipeIngredients = recipeIngredients.ToList();
        Steps = steps.ToList();
        ImageUri = imageUri;
    }
    public static Recipe Create(
        string name, 
        RecipeCategory category, 
        string description, 
        RecipeDetails details, 
        IEnumerable<RecipeIngredient> recipeIngredients, 
        IEnumerable<string> steps,
        Uri imageUri)
    {
        return new Recipe(name, DateTime.Now, category, description, details, recipeIngredients, steps, imageUri);
    }
    
    public void AddIngredient(RecipeIngredient recipeIngredient)
    {
        var newRecipeIngredients = RecipeIngredients.ToList();
        newRecipeIngredients.Add(recipeIngredient);

        RecipeIngredients = newRecipeIngredients;
    }
    
    public void AddStep(string step)
    {
        var newSteps = Steps.ToList();
        newSteps.Add(step);

        Steps = newSteps;
    }
    
    public void UpdateStepsOrder(int oldIndex, int newIndex)
    {
        var newSteps = Steps.ToList();
        var step = newSteps[oldIndex];
        newSteps.RemoveAt(oldIndex);
        newSteps.Insert(newIndex, step);

        Steps = newSteps;
    }
}
