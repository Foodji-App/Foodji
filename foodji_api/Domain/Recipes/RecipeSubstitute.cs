using Domain.Ingredients;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Recipes;

public class RecipeSubstitute
{
    [BsonId]
    public ObjectId Id { get; }
    
    public string Name { get; private set; }

    public string SubstitutionPrecisions { get; private set; } = String.Empty;

    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }

    public IEnumerable<Tag> Tags { get; private set; } = new List<Tag>();

    private RecipeSubstitute(
        string name,
        Measurement measurement,
        string description)
    {
        Name = name;
        Description = description;
        Measurement = measurement;
    }

    public static RecipeSubstitute Create(
        Measurement measurement,
        string name,
        string description,
        string substitutionPrecisions,
        IEnumerable<Tag> tags)
    {
        var recipeSubstitute = new RecipeSubstitute(
            name, measurement, description)
        {
            SubstitutionPrecisions = substitutionPrecisions,
            Tags = tags.ToList()
        };

        return recipeSubstitute;
    }
}