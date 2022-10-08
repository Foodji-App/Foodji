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
        
        // TODO - copy pasta shenanigans, we have to redo the method
        public async Task<Unit> Handle(CreateRecipeCommand request, CancellationToken cancellationToken)
        {
            var recipe = _mapper.Map<Recipe>(request.RecipeDto);
            
            _client.Recipes.InsertOne(recipe);
            
            return Unit.Value;
        }
    }
}