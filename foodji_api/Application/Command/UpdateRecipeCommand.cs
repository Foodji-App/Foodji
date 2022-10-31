using Application.Dto;
using AutoMapper;
using Infra;
using MediatR;
using Domain.Recipes;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Command;

public class UpdateRecipeCommand : IRequest<string>
{
    private RecipeDto RecipeDto { get; }
    
    public UpdateRecipeCommand(RecipeDto recipeDto)
    {
        RecipeDto = recipeDto;
    }
    
    private class Handler : IRequestHandler<UpdateRecipeCommand, string>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }
        
        public async Task<string> Handle(UpdateRecipeCommand request, CancellationToken cancellationToken)
        {
            var recipe = _mapper.Map<Recipe>(request.RecipeDto);
            
            var results = await _client.Recipes.FindAsync(
                x => x.Id == new ObjectId(request.RecipeDto.Id),
                cancellationToken: cancellationToken);

            var recipeToUpdateList = results.ToList(cancellationToken);
            
            switch (recipeToUpdateList.Count)
            {
                case > 1:
                    // TODO More specific exception to go along better exception handling in the API layer
                    //      500 many with the same ID (bad news!)
                    //      shouldn't happen, but no "FindOne" method to make that check for us
                    throw new Exception($"{recipeToUpdateList.Count} recipes with the id {request.RecipeDto.Id} found");
                case 0:
                    return string.Empty;
            }

            var recipeToUpdate = recipeToUpdateList.First();
            
            recipeToUpdate.Update(recipe);
            
            await _client.Recipes.ReplaceOneAsync(r => r.Id.Equals(recipeToUpdate.Id),
                recipeToUpdate, new ReplaceOptions { IsUpsert = false }, cancellationToken);

            return recipeToUpdate.Id.ToString();
        }
    }
}