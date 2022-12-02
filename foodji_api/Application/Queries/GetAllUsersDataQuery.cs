using Application.Dto;
using AutoMapper;
using Domain.Users;
using Infra;
using MediatR;
using MongoDB.Driver;

namespace Application.Queries;

public class GetAllUsersDataQuery : IRequest<IEnumerable<UserDataDto>>
{
    private class Handler : IRequestHandler<GetAllUsersDataQuery, IEnumerable<UserDataDto>>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }


        public async Task<IEnumerable<UserDataDto>> Handle(GetAllUsersDataQuery request, CancellationToken cancellationToken)
        {
            var usersData = await _client.UsersData.FindAsync(_ => true, cancellationToken: cancellationToken);

            return _mapper.Map<IEnumerable<UserData>, IEnumerable<UserDataDto>>(usersData.ToList());
        }
    }
}