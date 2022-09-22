using MongoDB.Driver;

namespace FoodjiApi.Queries;

public class GetAllRecipesCommand
{
    private IMongoClient _dbClient;
    
    public GetAllRecipesCommand(IMongoClient dbClient)
    {
        _dbClient = dbClient;
    }
    
    
}