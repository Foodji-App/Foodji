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

    public IEnumerable<RecipeSubstitute> Substitutes { get; private set; } = new List<RecipeSubstitute>();


    private RecipeIngredient(
        string description,
        Measurement measurement,
        string name)
    {
        Name = name;
        Description = description;
        Measurement = measurement;
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
    
    public void AddSubstitute(RecipeSubstitute substitute)
    {
        if (Substitutes.Any(x => x.Name == substitute.Name))
        {
            throw new DomainException("Cannot add a substitute with the same name as another substitute.");
        }

        var newSubstitutes = Substitutes.ToList();
        newSubstitutes.Add(substitute);

        Substitutes = newSubstitutes;
    }
}