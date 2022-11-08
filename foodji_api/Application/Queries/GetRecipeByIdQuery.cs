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
            var results = await _client.Recipes.FindAsync(
                x => x.Id == request.RecipeId, cancellationToken: cancellationToken);

            var recipe = results.SingleOrDefault(cancellationToken: cancellationToken);

            return recipe == null ? null : _mapper.Map<Recipe, RecipeDto>(recipe);
        }
    }
}