namespace Domain.Recipes;

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
        return new RecipeStep(content, index);
    }
}