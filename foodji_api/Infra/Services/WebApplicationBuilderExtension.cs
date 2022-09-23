using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using MongoDB.Driver;

namespace Infra.Services;

public static class WebApplicationBuilderExtension
{
    public static void SetupInfra(this WebApplicationBuilder webApplicationBuilder)
    {
        webApplicationBuilder.Services.AddSingleton<IMongoClient, MongoClient>(_ =>
            // TODO use secrets - not critical for the moment in local development ONLY
            new MongoClient(webApplicationBuilder.Configuration.GetSection("Database:MongoDB")["ConnectionString"]));
    }
}