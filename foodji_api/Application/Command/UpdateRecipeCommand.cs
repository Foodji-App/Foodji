using Application.Dto;
using AutoMapper;
using Infra;
using MediatR;
using Domain.Recipes;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Command;

public class UpdateRecipeCommand : IRequest<string?>
{
    private RecipeDto RecipeDto { get; }
    
    public UpdateRecipeCommand(RecipeDto recipeDto)
    {
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
            // We're using a session to do everything in a single transaction to avoid data incoherence
            using var session = await _client.StartSessionAsync(cancellationToken: cancellationToken);
            
            return await session.WithTransactionAsync<string?>(async (session, cancellationToken) =>
                {
                    var results = await _client.Recipes.FindAsync(
                        x => x.Id == new ObjectId(request.RecipeDto.Id),
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

                }, cancellationToken: cancellationToken);
        }
    }
}