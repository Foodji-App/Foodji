namespace Domain.Recipes;

public class RecipeDetails
{
    public int CookingTime { get; private set; }
    
    public int PreparationTime { get; private set; }
    
    public int RestingTime { get; private set; }
    
    public int Serves { get; private set; }
    
    public int TotalTime => CookingTime + PreparationTime + RestingTime;
    
    /* TODO - Do we want to keep the difficulty as a string or as an enum?
            Could be useful to have a list of difficulties, especially if we want to filter by language. */
    //public string Difficulty { get; private set; }
    
    private RecipeDetails(int cookingTime, int preparationTime, int restingTime, int serves)
    {
        CookingTime = cookingTime;
        PreparationTime = preparationTime;
        RestingTime = restingTime;
        Serves = serves;
    }
    
    // TODO - Determine what to do if any of the values are null.
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