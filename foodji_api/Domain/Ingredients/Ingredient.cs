using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Ingredients;

public class Ingredient
{
    [BsonId]
    public ObjectId Id { get; }
    
    public string Name { get; private set; }

    public IEnumerable<Tag> Tags { get; private set; } = new List<Tag>();
    
    public IEnumerable<Substitute> Substitutes { get; private set; } = new List<Substitute>();
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }

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

    public void AddSubstitute(Substitute substitute)
    {
        var newSubstitutes = Substitutes.ToList();
        newSubstitutes.Add(substitute);

        Substitutes = newSubstitutes;
    }
}