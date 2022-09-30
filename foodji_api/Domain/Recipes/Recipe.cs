namespace Domain.Recipes;

public class Recipe
{
    public string Name { get; private set; }
    
    public DateTime CreatedAt { get; private set; }
    
    // TODO - single or list of categories?
    public RecipeCategory Category { get; private set; }
    
    public RecipeDetails Details { get; private set; }
    
    public RecipeExcerpt Excerpt { get; private set; }
    
    public IEnumerable<RecipeIngredient> Ingredients { get; private set; }
    
    public IEnumerable<RecipeStep> Steps { get; private set; }
}

public class RecipeStep
{
    // TODO - what do we actually want to keep here?
    public int Index { get; private set; }
    
    public string Content { get; private set; }
}

public class RecipeExcerpt
{
    // TODO - short text / comment which appears while browsing recipes
    // TODO - check with FE if we actually want that or nah, and what limitations we might put on it
    //  (Length, mainly, because otherwise just a very standard string)
}

public class RecipeDetails
{
    // TODO - Cooking times, temperatures, etc.
}