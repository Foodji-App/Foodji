namespace Domain.Recipes;

public class RecipeDetails
{
    public int CookingTime { get; private set; }
    
    public int PreparationTime { get; private set; }
    
    public int RestingTime { get; private set; }
    
    public int Serves { get; private set; }
    
    public int TotalTime => CookingTime + PreparationTime + RestingTime;

    // TODO - Determine if recipe difficulty should be stored.
    
    private RecipeDetails(int cookingTime, int preparationTime, int restingTime, int serves)
    {
        CookingTime = cookingTime;
        PreparationTime = preparationTime;
        RestingTime = restingTime;
        Serves = serves;
    }
    
    static public RecipeDetails Create(
        int cookingTime = 0, 
        int preparationTime = 0, 
        int restingTime = 0, 
        int serves = 0)
    {
        return new RecipeDetails(
            cookingTime, 
            preparationTime, 
            restingTime, 
            serves);
    }
}