using Domain.Ingredients;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Recipes;

public class RecipeIngredient
{
    [BsonId]
    public ObjectId Id { get; }
    
    public string Name { get; private set; }
    
    public string Description { get; private set; }
    
    public Measurement Measurement { get; private set; }

    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }

    public IEnumerable<Tag> Tags { get; private set; } = new List<Tag>();

    public IEnumerable<RecipeSubstitute> RecipeSubstitutes { get; private set; } = new List<RecipeSubstitute>();


    private RecipeIngredient(
        string name,
        string description,
        Measurement measurement)
    {
        Name = name;
        Description = description;
        Measurement = measurement;
    }
    
    public static RecipeIngredient Create(
        string name,
        string description,
        Measurement measurement,
        IEnumerable<Tag> tags,
        IEnumerable<RecipeSubstitute> recipeSubstitutes)
    {
        var recipeIngredient = new RecipeIngredient(name, description, measurement)
        {
            RecipeSubstitutes = recipeSubstitutes.ToList(),
            Tags = tags.ToList()
        };

        return recipeIngredient;
    }
    
    public void AddTag(Tag tag)
    {
        var newTags = Tags.ToList();
        if (newTags.Contains(tag))
        {
            throw new DomainException($"Ingredient already has tag {tag.Name}");
        }
        
        newTags.Add(tag);
        Tags = newTags;
    }

    public void AddSubstitute(RecipeSubstitute recipeSubstitute)
    {
        var newRecipeSubstitutes = RecipeSubstitutes.ToList();
        newRecipeSubstitutes.Add(recipeSubstitute);

        RecipeSubstitutes = newRecipeSubstitutes;
    }
}