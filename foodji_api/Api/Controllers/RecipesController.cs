using Application.Command;
using Application.Dto;
using Application.Queries;
using Auth;
using Auth.Policies;
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
    private readonly IAuthorizationService _authorizationService;
    
    public RecipesController(IMediator mediator, IAuthorizationService authorizationService)
    {
        _mediator = mediator;
        _authorizationService = authorizationService;
    }


    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IEnumerable<RecipeDto>))]
    public async Task<IActionResult> GetAllRecipes()
    {
        var userId = User.Claims.First(x => x.Type == "user_id").Value;
        var query = new GetAllRecipesFromUserQuery(userId);
        
        // TODO refactor eventually with query param for public + user's
        // TODO currently disabled the get *all* even for admins, probably also a query param eventually
        // var query = new GetAllRecipesQuery();
        
        var result =  await _mediator.Send(query);
        
        // TODO bit of a particular case here, and can be reviewed with refactor
        // but if null, it's the user who isn't found, so we return a 401
        // Should be impossible, because of the authorization requirements
        if (result == null)
        {
            return Unauthorized();
        }

        return Ok(result);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(RecipeDto))]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetRecipe([FromRoute] string id)
    {
        // Check access rights
        var authResult = await Authorize(id, FoodjiRecipeAccessRequirement.Policy);

        if (!authResult.Succeeded)
        {
            return Forbid();
        }
        
        // Get the recipe
        var query = new GetRecipeByIdQuery(id);

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
        // Get the author's user id from the authentication context
        recipe.Author = User.Claims.First(x => x.Type == "user_id").Value;
        
        var command = new CreateRecipeCommand(recipe);

        var result = await _mediator.Send(command);

        return CreatedAtAction(nameof(GetRecipe), new {id = result}, new {});
    }
    
    [HttpPut]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> UpdateRecipe([FromBody] RecipeDto recipe)
    {
        // Check access rights
        // TODO refactor so the id is in the route, NOT the DTO (nullable warning)
        var authResult = await Authorize(recipe.Id!, FoodjiRecipeAccessRequirement.Policy);

        if (!authResult.Succeeded)
        {
            return Forbid();
        }
        
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
        // Check access rights
        var authResult = await Authorize(id, FoodjiRecipeAccessRequirement.Policy);

        if (!authResult.Succeeded)
        {
            return Forbid();
        }
        
        var command = new DeleteRecipeCommand(id);

        var result = await _mediator.Send(command);
        
        if (string.IsNullOrEmpty(result))
        {
            return NotFound();
        }

        return NoContent();
    }

    /// <summary>
    /// Convenience method to wrap getting the recipe details from its id to check against a policy.
    /// </summary>
    /// <param name="recipeId">The id of the recipe against which to check authorization.</param>
    /// <param name="policy">The name of the policy by which to evaluate authorization.</param>
    /// <returns>The resulting <see cref="AuthorizationResult"/></returns>
    private async Task<AuthorizationResult> Authorize(string recipeId, string policy)
    {
        var accessRightsQuery = new GetRecipeAccessRightsQuery(recipeId);
        var recipeAccessRights = await _mediator.Send(accessRightsQuery);
        
        return await _authorizationService
            .AuthorizeAsync(User, recipeAccessRights, policy);
    }
}
