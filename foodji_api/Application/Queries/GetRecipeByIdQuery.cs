using Application.Dto;
using AutoMapper;
using Domain.Recipes;
using Infra;
using MediatR;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Queries;

public class GetRecipeByIdQuery : IRequest<RecipeDto?>
{
    private string RecipeId { get; }

    public GetRecipeByIdQuery(string recipeId)
    {
        RecipeId = recipeId;
    }
    
    private class Handler : IRequestHandler<GetRecipeByIdQuery, RecipeDto?>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }


        public async Task<RecipeDto?> Handle(GetRecipeByIdQuery request, CancellationToken cancellationToken)
        {
            // Safe parsing the string into an ObjectId. Return null if the id is malformed
            if (!ObjectId.TryParse(request.RecipeId, out var id))
            {
                return null;
            }
            
            var results = await _client.Recipes.FindAsync(
                x => x.Id == id, cancellationToken: cancellationToken);

            var recipe = results.SingleOrDefault(cancellationToken: cancellationToken);

            return recipe == null ? null : _mapper.Map<Recipe, RecipeDto>(recipe);
        }
    }
}