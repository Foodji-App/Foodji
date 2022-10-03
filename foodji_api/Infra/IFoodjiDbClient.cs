using Domain.Ingredients;
using Domain.Recipes;
using MongoDB.Driver;

namespace Infra;

public interface IFoodjiDbClient
{
    public IMongoCollection<Ingredient> Ingredients { get; }

    public IMongoCollection<Recipe> Recipes { get; }
}