using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Ingredients;

public class Substitute
{
    [BsonId]
    public ObjectId Id { get; }
    
    public string Name { get; private set; }

    public string SubstitutionPrecisions { get; private set; } = String.Empty;

    public IEnumerable<Tag> Tags { get; private set; } = new List<Tag>();

    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }
    
    protected Substitute(string name)
    {
        Name = name;
    }

    public static Substitute Create(string name, string substitutionPrecisions, IEnumerable<Tag> tags)
    {
        return new Substitute(name)
        {
            Tags = tags.ToList(),
            SubstitutionPrecisions = substitutionPrecisions
        };
    }
}