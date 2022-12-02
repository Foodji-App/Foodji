using Application.Dto;
using AutoMapper;
using Domain.Users;
using Infra;
using MediatR;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Queries;

public class GetUserDataByIdQuery : IRequest<UserDataDto?>
{
    private string UserId { get; }

    public GetUserDataByIdQuery(string userId)
    {
        UserId = userId;
    }
    
    private class Handler : IRequestHandler<GetUserDataByIdQuery, UserDataDto?>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }


        public async Task<UserDataDto?> Handle(GetUserDataByIdQuery request, CancellationToken cancellationToken)
        {
            var results = await _client.UsersData.FindAsync(
                x => x.Id == request.UserId, cancellationToken: cancellationToken);

            var userData = results.SingleOrDefault(cancellationToken: cancellationToken);

            return userData == null ? null : _mapper.Map<UserData, UserDataDto>(userData);
        }
    }
}