using MongoDB.Driver;

namespace FoodjiApi;

public class DbManager
{
    private readonly IMongoClient _dbClient;

    public DbManager(IMongoClient dbClient)
    {
        _dbClient = dbClient;
    }

    /// <summary>
    /// Initializes the MongoDB database on startup of the application, for whatever elements are not yet created.
    /// If elements of the initialization are already present, there is no danger in calling this method,
    /// it will simply leave them as-is.
    /// </summary>
    public void InitDb()
    {
        // Create schema validation
        // TODO
        
        // Create indexes
        // TODO
    }
}