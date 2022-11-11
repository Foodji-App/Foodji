using System.Reflection;
using Api.Auth.Extensions;
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

// Map dependency injection
builder.Services.SetupInfra(
    // TODO use secrets - not critical for the moment in local development ONLY
    builder.Configuration.GetSection("Database:MongoDB")["ConnectionString"]);

builder.Services.AddMediatR(Assembly.Load("Application"));
builder.Services.AddAutoMapper(Assembly.Load("Application"));

// This whole manipulation would very likely benefit from better configuration handling,
// in addition to secrets handling. This is better left to another task, however.
var executingAssemblyDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
var firebaseCredentialsFileName = builder.Configuration["Auth:Firebase:CredentialsFile"];
// If the directory of the executing assembly is null, we have bigger problems
var firebaseCredentials = Path.Combine(executingAssemblyDirectory!, firebaseCredentialsFileName);

Console.WriteLine($"Credentials: {firebaseCredentials}");
builder.Services.AddFirebaseJwtAuthentication(firebaseCredentials);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
