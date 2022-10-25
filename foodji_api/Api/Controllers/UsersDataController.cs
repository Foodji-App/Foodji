using Application.Command;
using Application.Dto;
using Application.Queries;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("usersData")]
public class UsersDataController : ControllerBase
{
    private readonly IMediator _mediator;
    
    public UsersDataController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IEnumerable<UserDataDto>))]
    public async Task<IActionResult> GetAllUsersData()
    {
        var query = new GetAllUsersDataQuery();
        
        var result =  await _mediator.Send(query);
        
        return Ok(result);
    }

    [HttpPost]
    // [ProducesResponseType(StatusCodes.Status201Created)]
    public async Task CreateUserData([FromBody] UserDataDto userData)
    {
        var command = new CreateUserDataCommand(userData);

        var result = await _mediator.Send(command);

        // return Created(result);
    }
}
