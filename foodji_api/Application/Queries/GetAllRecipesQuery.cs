using Api.DbRepresentations.Ingredients;
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


        public async Task<Unit> Handle(GetAllRecipesQuery request, CancellationToken cancellationToken)
        {
            var temp = new Dictionary<string, string>();
            temp.Add("testKey", "testValue");
            
            await _client.GetDatabase("foodji")
                .GetCollection<Dictionary<string, string>>()
                .InsertOneAsync(temp, cancellationToken);

            return default;
        }
    }
}