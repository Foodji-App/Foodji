using Application.Dto;
using AutoMapper;
using Domain.Recipes;
using Domain.Users;
using Infra;
using MediatR;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Application.Queries;

public class GetUserDataByIdQuery : IRequest<UserDataDto?>
{
    private ObjectId UserDataId { get; }

    public GetUserDataByIdQuery(string recipeId)
    {
        UserDataId = new ObjectId(recipeId);
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
            var results = await _client.UsersData.FindAsync(x => x.Id.Equals(request.UserDataId), cancellationToken: cancellationToken);

            var usersData = results.ToList();
            
            if (usersData.Count > 1)
            {
                // TODO More specific exception to go along better exception handling in the API layer
                //      500 many with the same ID (bad news!)
                //      shouldn't happen, but no "FindOne" method to make that check for us
                throw new Exception($"{usersData.Count} usersData with the id {request.UserDataId} found");
            }

            if (usersData.Count == 0)
            {
                return null;
            }
            
            return _mapper.Map<UserData, UserDataDto>(usersData[0]);
        }
    }
}