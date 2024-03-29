﻿namespace Domain.Users;

public class UserData
{
    // string and not ObjectId because this is a Firebase id, not a Mongo one (different format)
    public string Id { get; set; }
    
    public IEnumerable<string> Recipes { get; set; }
    

    private UserData(string id, IEnumerable<string> recipes)
    {
        Id = id;
        Recipes = recipes.ToList();
    }

    public static UserData Create(string id, IEnumerable<string> recipes)
    {
        return new UserData(id, recipes);
    }
    
    public void AddRecipe(string recipeId)
    {
        if (!Recipes.Contains(recipeId))
        { 
            Recipes = Recipes.Append(recipeId);
        }
    }
    
    public void RemoveRecipe(string recipeId)
    {
        if (Recipes.Contains(recipeId))
        {
            var newRecipes = Recipes.ToList();
            newRecipes.Remove(recipeId);
            Recipes = newRecipes;            
        }
    }
}