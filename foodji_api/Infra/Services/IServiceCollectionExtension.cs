﻿using Microsoft.Extensions.DependencyInjection;
using MongoDB.Driver;

namespace Infra.Services;

public static class ServiceCollectionExtension
{
    public static void SetupInfra(this IServiceCollection services, string connectionString)
    {
        services.AddSingleton<IFoodjiDbClient, FoodjiDbClient>(_ =>
            new FoodjiDbClient(connectionString));
    }
}