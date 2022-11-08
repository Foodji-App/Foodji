using Application.Command;
using Application.Dto;
using Application.Queries;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("recipes")]
[Authorize]
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
    [ProducesResponseType(StatusCodes.Status201Created)]
    public async Task<IActionResult> CreateRecipe([FromBody] RecipeDto recipe)
    {
        var command = new CreateRecipeCommand(recipe);

        var result = await _mediator.Send(command);

        return CreatedAtAction(nameof(GetRecipe), new {id = result}, new {});
    }
    
    [HttpPut]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> UpdateRecipe([FromBody] RecipeDto recipe)
    {
        var command = new UpdateRecipeCommand(recipe);

        var result = await _mediator.Send(command);
        
        if (string.IsNullOrEmpty(result))
        {
            return NotFound();
        }

        return CreatedAtAction(nameof(GetRecipe), new {id = result}, new {});
    }
    
    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> DeleteRecipe([FromRoute] string id)
    {
        var command = new DeleteRecipeCommand(id);

        var result = await _mediator.Send(command);
        
        if (string.IsNullOrEmpty(result))
        {
            return NotFound();
        }

        return NoContent();
    }
}
