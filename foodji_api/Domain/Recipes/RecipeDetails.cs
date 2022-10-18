namespace Domain.Recipes;

public class RecipeDetails
{
    public int CookingTime { get; private set; }
    
    public int PreparationTime { get; private set; }
    
    public int RestingTime { get; private set; }
    
    public int Serves { get; private set; }
    
    public int TotalTime => CookingTime + PreparationTime + RestingTime;

    private RecipeDetails(int cookingTime, int preparationTime, int restingTime, int serves)
    {
        CookingTime = cookingTime;
        PreparationTime = preparationTime;
        RestingTime = restingTime;
        Serves = serves;
    }
    
    public static RecipeDetails Create(
        int cookingTime, 
        int preparationTime, 
        int restingTime, 
        int serves)
    {
        return new RecipeDetails(
            cookingTime, 
            preparationTime, 
            restingTime, 
            serves);
    }
}