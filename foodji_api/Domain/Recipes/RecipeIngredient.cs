﻿using Domain.Ingredients;

namespace Domain.Recipes;

public class RecipeIngredient : Ingredient
{
    public string Description { get; protected set; }
    
    public Measurement Measurement { get; protected set; }
    
    // TODO - Refactor method after merge
    private RecipeIngredient(
        string description,
        Measurement measurement,
        string name,
        IEnumerable<RecipeSubstitute> substitutes,
        IEnumerable<Tag> tags)
            : base(name, tags, substitutes)
    {
        Description = description;
        Measurement = measurement;
        Name = name;
    }
    
    public static RecipeIngredient Create(
        Measurement measurement,
        string name,
        string description = "",
        IEnumerable<Tag>? tags = null,
        IEnumerable<RecipeSubstitute>? substitutes = null)
    {
        return new RecipeIngredient(
            description,
            measurement,
            name,
            substitutes ?? Enumerable.Empty<RecipeSubstitute>(),
            tags ?? Enumerable.Empty<Tag>());
    }
}