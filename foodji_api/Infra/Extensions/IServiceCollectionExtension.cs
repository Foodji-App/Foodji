using Domain.Recipes;
using Microsoft.Extensions.DependencyInjection;
using MongoDB.Driver;

namespace Infra.Extensions;

public static class ServiceCollectionExtension
{
    public static void SetupInfra(this IServiceCollection services, string connectionString)
    {
        services.AddSingleton<IFoodjiDbClient, FoodjiDbClient>(_ =>
        {
            var client = new FoodjiDbClient(connectionString);
            
            /*
             Food for thought: should we create the index here or when initializing the api/database?
             Currently, we think the index is created when the api receives its first request, which momentarily 
             slows down the response. This could potentially be avoided by creating the index when building the 
             api instead. This could also be avoided by having a separate micro-service whose purpose would be to
             create indexes and schema validations. 
             */
            
            client.Recipes.Indexes
                .CreateOneAsync(new CreateIndexModel<Recipe>(
                    Builders<Recipe>.IndexKeys.Hashed(recipe => recipe.Author)));

            return client;
        });
    }
}