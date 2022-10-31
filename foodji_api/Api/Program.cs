using System.Reflection;
using Infra.Services;
using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
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
            new string[] {}
        }
    });
});

// Map dependency injection
builder.Services.SetupInfra(
    // TODO use secrets - not critical for the moment in local development ONLY
    builder.Configuration.GetSection("Database:MongoDB")["ConnectionString"]);

builder.Services.AddMediatR(Assembly.Load("Application"));
builder.Services.AddAutoMapper(Assembly.Load("Application"));

builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        var firebaseConfig = builder.Configuration.GetSection("Auth:Firebase");
        // Adds the *authentication* part of the process
        // https://blog.markvincze.com/secure-an-asp-net-core-api-with-firebase/
        // and needed for the authorization part, which we have to customize.
        // See https://learn.microsoft.com/en-us/aspnet/core/security/authorization/resourcebased?view=aspnetcore-6.0
        options.Authority = firebaseConfig["Authority"];
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = firebaseConfig["Authority"],
            ValidateAudience = true,
            ValidAudience = firebaseConfig["Audience"],
            ValidateLifetime = true
        };
    });

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
