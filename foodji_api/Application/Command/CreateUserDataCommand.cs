using Application.Dto;
using AutoMapper;
using Infra;
using MediatR;
using Domain.Users;

namespace Application.Command;

public class CreateUserDataCommand : IRequest<string>
{
    public UserDataDto UserDataDto { get; }
    
    public CreateUserDataCommand(UserDataDto userDataDto)
    {
        UserDataDto = userDataDto;
    }
    
    private class Handler : IRequestHandler<CreateUserDataCommand, string>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }
        
        public async Task<string> Handle(CreateUserDataCommand request, CancellationToken cancellationToken)
        {
            var userData = _mapper.Map<UserData>(request.UserDataDto);

            await _client.UsersData.InsertOneAsync(userData, cancellationToken: cancellationToken);

            return userData.Id;
        }
    }
}