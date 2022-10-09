﻿namespace Domain.Recipes;

public class RecipeStep
{
    public string Content { get; private set; }
    
    // TODO - what do we actually want to keep here?
    public int Index { get; private set; }
    
    private RecipeStep(string content, int index)
    {
        Content = content;
        Index = index;
    }
    
    public static RecipeStep Create(string content, int index)
    {
        if (String.IsNullOrEmpty(content) || index < 0)
            throw new DomainException(
                "The content cannot be null or empty and the index cannot be less than 0.");
        
        return new RecipeStep(content, index);
    }
}