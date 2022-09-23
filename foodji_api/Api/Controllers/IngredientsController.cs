using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route(("ingredients"))]
public class IngredientsController : ControllerBase
{
    [HttpGet]
    public IEnumerable<string> GetAllIngredients()
    {
        return Enumerable.Empty<string>();
    }
}