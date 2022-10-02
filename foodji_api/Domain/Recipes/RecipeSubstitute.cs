﻿using Domain.Ingredients;

namespace Domain.Recipes;

public class RecipeSubstitute : Substitute
{
    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
    private RecipeSubstitute(
        string name,
        Measurement measurement,
        string description)
            : base(name)
    {
        Description = description;
        Measurement = measurement;
    }

    public static RecipeSubstitute Create(
        Measurement measurement,
        string name,
        string description = "",
        string substitutionPrecisions = "",
        IEnumerable<Tag>? tags = null)
    {
        var recipeSubstitute = new RecipeSubstitute(
            name, measurement, description);

        recipeSubstitute.SubstitutionPrecisions = substitutionPrecisions;

        if (tags != null)
        {
            recipeSubstitute.Tags = tags.ToList();
        }

        return recipeSubstitute;
    }
}