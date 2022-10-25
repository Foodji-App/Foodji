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
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IEnumerable<RecipeDto>))]
    public async Task<IActionResult> GetAllRecipes()
    {
        var query = new GetAllRecipesQuery();
        
        var result =  await _mediator.Send(query);
        
        return Ok(result);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(RecipeDto))]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetRecipe([FromRoute] string id)
    {
        var query = new GetRecipeByIdQuery(id);

        var result = await _mediator.Send(query);

        if (result == null)
        {
            return NotFound();
        }

        return Ok(result);
    }
    
    [HttpGet("users/{id}")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IEnumerable<RecipeDto>))]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetAllRecipesFromUser([FromRoute] string id)
    {
        var query = new GetAllRecipesFromUserQuery(id);

        var result = await _mediator.Send(query);

        if (result == null)
        {
            return NotFound();
        }

        return Ok(result);
    }

    [HttpPost]
    // [ProducesResponseType(StatusCodes.Status201Created)]
    public async Task CreateRecipe([FromBody] RecipeDto recipe)
    {
        var command = new CreateRecipeCommand(recipe);

        var result = await _mediator.Send(command);

        // return Created(result);
    }
}
