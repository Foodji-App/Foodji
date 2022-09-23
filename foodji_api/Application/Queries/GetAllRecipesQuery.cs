using MediatR;
using MongoDB.Driver;

namespace Application.Queries;

public class GetAllRecipesQuery : IRequest
{
    private class Handler : IRequestHandler<GetAllRecipesQuery>
    {
        private readonly IMongoClient _client;

        public Handler(IMongoClient client)
        {
            _client = client;
        }


        public Task<Unit> Handle(GetAllRecipesQuery request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}