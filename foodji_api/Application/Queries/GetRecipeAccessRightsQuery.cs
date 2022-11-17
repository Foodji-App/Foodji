using Application.Dto;
using AutoMapper;
using Domain.Recipes;
using Infra;
using MediatR;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Queries;

public class GetRecipeAccessRightsQuery : IRequest<RecipeAccessRightsDto?>
{
    private string RecipeId { get; }

    public GetRecipeAccessRightsQuery(string recipeId)
    {
        RecipeId = recipeId;
    }
    
    private class Handler : IRequestHandler<GetRecipeAccessRightsQuery, RecipeAccessRightsDto?>
    {
        private readonly IFoodjiDbClient _client;

        public Handler(IFoodjiDbClient client)
        {
            _client = client;
        }

        public async Task<RecipeAccessRightsDto?> Handle(GetRecipeAccessRightsQuery request, CancellationToken cancellationToken)
        {
            // Safe parsing the string into an ObjectId. Return null if the id is malformed
            ObjectId id;
            if (!ObjectId.TryParse(request.RecipeId, out id))
            {
                return null;
            }
            
            var results = await _client.Recipes.FindAsync(
                x => x.Id == id, cancellationToken: cancellationToken);

            var recipe = results.SingleOrDefault(cancellationToken: cancellationToken);

            return recipe == null ? null : new RecipeAccessRightsDto{ AuthorId = recipe.Author };
        }
    }
}