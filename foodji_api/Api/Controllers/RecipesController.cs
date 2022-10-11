using Application.Command;
using Application.Dto;
using Application.Queries;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("recipes")]
public class RecipesController : ControllerBase
{
    private readonly IMediator _mediator;
    
    public RecipesController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public async Task<IEnumerable<RecipeDto>> GetAllRecipes()
    {
        var query = new GetAllRecipesQuery();
        
        var result =  await _mediator.Send(query);
        
        return result;
    }


    [HttpPost]
    public async Task CreateRecipe([FromBody] RecipeDto recipe)
    {
        var command = new CreateRecipeCommand(recipe);

        var result = await _mediator.Send(command);
    }
}
