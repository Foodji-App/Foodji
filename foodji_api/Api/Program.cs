using System.Reflection;
using Auth.Extensions;
using Infra.Extensions;
using MediatR;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    // Add support for authorize button in Swagger
    // https://www.thecodebuzz.com/jwt-authorization-token-swagger-open-api-asp-net-core-3-0/
    c.AddSecurityDefinition("bearerAuth", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "JWT Authorization header using the Bearer scheme."
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "bearerAuth"
                }
            },
            Array.Empty<string>()
        }
    });
});

// TODO use secrets - not critical for the moment in local development ONLY
var connectionAddress = builder.Environment.IsDevelopment()
    ? "localhost:27017"
    : Environment.GetEnvironmentVariable("DB_ADDR");

if (connectionAddress == null)
    throw new Exception("Database address is null");

// Map dependency injection
builder.Services.SetupInfra(
    $"{builder.Configuration.GetSection("MongoDB")["ConnectionString"]}@{connectionAddress}");

builder.Services.AddMediatR(Assembly.Load("Application"));
builder.Services.AddAutoMapper(Assembly.Load("Application"));

// Keep these two in order
builder.Services.AddFirebaseJwtAuthentication(builder.Configuration);
builder.Services.AddFoodjiAuthorization();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

/**
 * À conserver pour des hostings futurs. Dans certains infras,
 * on préfèrerait gérer le tout avec le reversed proxy et un certificate manager.
**/
//app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
