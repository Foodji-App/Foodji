using Domain.Ingredients;
using Domain.Recipes;
using Domain.Users;
using MongoDB.Driver;

namespace Infra;

public interface IFoodjiDbClient : IMongoClient
{
    public IMongoCollection<Ingredient> Ingredients { get; }

    public IMongoCollection<Recipe> Recipes { get; }
    
    public IMongoCollection<UserData> UsersData { get; }
}