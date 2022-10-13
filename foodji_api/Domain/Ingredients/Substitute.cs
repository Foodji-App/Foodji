using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Ingredients;

public class Substitute
{
    [BsonId]
    public ObjectId Id { get; }
    
    public string Name { get; private set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }

    public IEnumerable<Tag> Tags { get; private set; } = new List<Tag>();
    
    public string SubstitutionPrecisions { get; private set; } = String.Empty;

    protected Substitute(string name)
    {
        Name = name;
    }

    public static Substitute Create(string name, IEnumerable<Tag> tags, string substitutionPrecisions)
    {
        return new Substitute(name)
        {
            Tags = tags.ToList(),
            SubstitutionPrecisions = substitutionPrecisions
        };
    }
}