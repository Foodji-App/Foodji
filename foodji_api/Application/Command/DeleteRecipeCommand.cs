using AutoMapper;
using Infra;
using MediatR;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Command;

public class DeleteRecipeCommand : IRequest<string?>
{
    private ObjectId RecipeId { get; }
    
    public DeleteRecipeCommand(string recipeId)
    {
        RecipeId = new ObjectId(recipeId);
    }
    
    private class Handler : IRequestHandler<DeleteRecipeCommand, string?>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }
        
        public async Task<string?> Handle(DeleteRecipeCommand request, CancellationToken cancellationToken)
        {
            var result = await _client.Recipes.DeleteOneAsync(
                r => r.Id == request.RecipeId,
                cancellationToken: cancellationToken);

            return result.IsAcknowledged ? request.RecipeId.ToString() : null;
        }
    }
}