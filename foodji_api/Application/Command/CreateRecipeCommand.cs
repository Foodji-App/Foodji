using Application.Dto;
using AutoMapper;
using Infra;
using MediatR;
using Domain.Recipes;

namespace Application.Command;

public class CreateRecipeCommand : IRequest<string>
{
    public RecipeDto RecipeDto { get; }
    
    public CreateRecipeCommand(RecipeDto recipeDto)
    {
        RecipeDto = recipeDto;
    }
    
    private class Handler : IRequestHandler<CreateRecipeCommand, string>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }
        
        public async Task<string> Handle(CreateRecipeCommand request, CancellationToken cancellationToken)
        {
            var recipe = _mapper.Map<Recipe>(request.RecipeDto);

            await _client.Recipes.InsertOneAsync(recipe, cancellationToken: cancellationToken);

            return recipe.Id.ToString();
        }
    }
}