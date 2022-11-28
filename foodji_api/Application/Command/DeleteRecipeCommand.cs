using AutoMapper;
using Infra;
using MediatR;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Command;

public class DeleteRecipeCommand : IRequest<string?>
{
    private string RecipeId { get; }
    
    public DeleteRecipeCommand(string recipeId)
    {
        RecipeId = recipeId;
    }
    
    private class Handler : IRequestHandler<DeleteRecipeCommand, string?>
    {
        private readonly IFoodjiDbClient _client;

        public Handler(IFoodjiDbClient client)
        {
            _client = client;
        }
        
        public async Task<string?> Handle(DeleteRecipeCommand request, CancellationToken cancellationToken)
        {
            // Safe parsing the string into an ObjectId. Return null if the id is malformed
            if (!ObjectId.TryParse(request.RecipeId, out var id))
            {
                return null;
            }
            
            var result = await _client.Recipes.DeleteOneAsync(
                r => r.Id == id,
                cancellationToken: cancellationToken);

            return result.DeletedCount > 0 ? request.RecipeId : null;
        }
    }
}