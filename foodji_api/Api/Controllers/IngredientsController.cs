using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("ingredients")]
[Authorize]
public class IngredientsController : ControllerBase
{
    [HttpGet]
    public IEnumerable<string> GetAllIngredients()
    {
        return Enumerable.Empty<string>();
    }
}