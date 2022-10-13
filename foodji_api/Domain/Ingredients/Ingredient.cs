using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Ingredients;

public class Ingredient
{
    [BsonId]
    public ObjectId Id { get; }
    
    public string Name { get; private set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }

    public IEnumerable<Tag> Tags { get; private set; } = new List<Tag>();
    
    public IEnumerable<Substitute> Substitutes { get; set; } = new List<Substitute>();

    private Ingredient(string name)
    {
        Name = name;
    }
    
    public static Ingredient Create(
        string name,
        IEnumerable<Tag> tags,
        IEnumerable<Substitute> substitutes)
    {
        var ingredient = new Ingredient(name) 
        { 
            Tags = tags.ToList(), 
            Substitutes = substitutes.ToList() 
        };

        return ingredient;
    }

    public void AddSubstitute(Substitute substitute)
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