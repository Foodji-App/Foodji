﻿using Application.Dto;
using AutoMapper;
using Infra;
using MediatR;
using Domain.Recipes;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Command;

public class UpdateRecipeCommand : IRequest<string?>
{
    private string RecipeId { get; }
    private RecipeDto RecipeDto { get; }
    
    public UpdateRecipeCommand(string recipeId, RecipeDto recipeDto)
    {
        RecipeId = recipeId;
        RecipeDto = recipeDto;
    }
    
    private class Handler : IRequestHandler<UpdateRecipeCommand, string?>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }
        
        public async Task<string?> Handle(UpdateRecipeCommand request, CancellationToken cancellationToken)
        {
            // TODO Error about "standalone servers" not supporting transactions with Mongo, so commented out here
            // But would still be relevant to fix to ensure the incoherence mentioned above
            // We're using a session to do everything in a single transaction to avoid data incoherence
            // using var session = await _client.StartSessionAsync(cancellationToken: cancellationToken);
    
            // return await session.WithTransactionAsync<string?>(async (session, cancellationToken) =>
            //     {
                    // Safe parsing the string into an ObjectId. Return null if the id is malformed
                    if (!ObjectId.TryParse(request.RecipeId, out var recipeId))
                    {
                        return null;
                    }
                    
                    var results = await _client.Recipes.FindAsync(
                        x => x.Id == recipeId,
                        cancellationToken: cancellationToken);
            
                    var recipeToUpdate = results.SingleOrDefault(cancellationToken);

                    if (recipeToUpdate ==  null)
                    {
                        return null;
                    }

                    recipeToUpdate.Update(
                        request.RecipeDto.Name,
                        _mapper.Map<RecipeCategory>(request.RecipeDto.Category),
                        request.RecipeDto.Description,
                        _mapper.Map<RecipeDetails>(request.RecipeDto.Details),
                        _mapper.Map<IEnumerable<RecipeIngredientDto>, 
                            IEnumerable<RecipeIngredient>>(request.RecipeDto.Ingredients),
                        request.RecipeDto.Steps,
                        request.RecipeDto.ImageUri);
            
                    await _client.Recipes.ReplaceOneAsync(r => r.Id.Equals(recipeToUpdate.Id),
                        recipeToUpdate, new ReplaceOptions { IsUpsert = false }, cancellationToken);
                    
                    return recipeToUpdate.Id.ToString();

                // }, cancellationToken: cancellationToken);
        }
    }
}