using Application.Dto;
using AutoMapper;
using Infra;
using MediatR;
using Domain.Recipes;

namespace Application.Command;

public class CreateRecipeCommand : IRequest
{
    public CreateRecipeCommand(RecipeDto recipeDto)
    {
        RecipeDto = recipeDto;
    }
    
    public RecipeDto RecipeDto { get; }
    
    private class Handler : IRequestHandler<CreateRecipeCommand>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }
        
        public async Task<Unit> Handle(CreateRecipeCommand request, CancellationToken cancellationToken)
        {
            var recipe = _mapper.Map<Recipe>(request.RecipeDto);
            
            await _client.Recipes.InsertOneAsync(recipe, cancellationToken: cancellationToken);
            
            return Unit.Value;
        }
    }
}