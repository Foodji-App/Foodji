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
    private ObjectId RecipeId { get; }

    public GetRecipeByIdQuery(string recipeId)
    {
        RecipeId = new ObjectId(recipeId);
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
            var results = await _client.Recipes.FindAsync(x => x.Id == request.RecipeId, cancellationToken: cancellationToken);

            var recipes = results.ToList();
            
            if (recipes.Count > 1)
            {
                // TODO More specific exception to go along better exception handling in the API layer
                //      500 many with the same ID (bad news!)
                //      shouldn't happen, but no "FindOne" method to make that check for us
                throw new Exception($"{recipes.Count} recipes with the id {request.RecipeId}");
            }

            if (recipes.Count == 0)
            {
                return null;
            }
            
            return _mapper.Map<Recipe, RecipeDto>(recipes[0]);
        }
    }
}