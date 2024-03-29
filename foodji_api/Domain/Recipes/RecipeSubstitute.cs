﻿using Domain.Ingredients;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Domain.Recipes;

public class RecipeSubstitute
{
    [BsonId]
    public ObjectId Id { get; }
    
    public string Name { get; private set; }

    public string SubstitutionPrecision { get; private set; } = string.Empty;

    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
    // TODO - will implement later
    // public IEnumerable<string> Synonyms { get; private set; }

    public IEnumerable<Tag> Tags { get; private set; } = new List<Tag>();

    private RecipeSubstitute(
        string name,
        string description,
        Measurement measurement)
    {
        Name = name;
        Description = description;
        Measurement = measurement;
    }

    public static RecipeSubstitute Create(
        string name,
        string substitutionPrecision,
        string description,
        Measurement measurement,
        IEnumerable<Tag> tags)
    {
        var recipeSubstitute = new RecipeSubstitute(
            name, description, measurement)
        {
            SubstitutionPrecision = substitutionPrecision,
            Tags = tags.ToList()
        };

        return recipeSubstitute;
    }
    
    public void AddTag(Tag tag)
    {
        var newTags = Tags.ToList();
        if (newTags.Contains(tag))
        {
            throw new DomainException($"Substitute ingredient already has tag {tag.Name}");
        }
        
        newTags.Add(tag);
        Tags = newTags;
    }
}