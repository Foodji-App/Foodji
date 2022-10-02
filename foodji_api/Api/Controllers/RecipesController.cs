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
    public async Task<IEnumerable<string>> GetAllRecipes()
    {
        var query = new GetAllRecipesQuery();
        var result =  await _mediator.Send(query);
        
        return Enumerable.Empty<string>();
    }


    [HttpPost]
    public async Task CreateRecipe(RecipeDto recipe)
    {
        
    }
}

public class RecipeDto
{
    
}
