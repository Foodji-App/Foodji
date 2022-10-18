using Domain.Ingredients;
using Domain.Recipes;
using MongoDB.Driver;

namespace Infra;

public class FoodjiDbClient : MongoClient, IFoodjiDbClient
{
    private readonly IMongoDatabase _database;

    public FoodjiDbClient(string connectionString)
        : base(connectionString)
    {
        _database = GetDatabase("foodji");
    }
    
    public IMongoCollection<Ingredient> Ingredients => _database.GetCollection<Ingredient>("ingredients");

    public IMongoCollection<Recipe> Recipes => _database.GetCollection<Recipe>("recipes");
}