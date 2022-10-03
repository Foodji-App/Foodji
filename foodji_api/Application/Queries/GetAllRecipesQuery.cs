using Infra;
using MediatR;

namespace Application.Queries;

public class GetAllRecipesQuery : IRequest
{
    private class Handler : IRequestHandler<GetAllRecipesQuery>
    {
        private readonly IFoodjiDbClient _client;

        public Handler(IFoodjiDbClient client)
        {
            _client = client;
        }


        public async Task<Unit> Handle(GetAllRecipesQuery request, CancellationToken cancellationToken)
        {
            var temp = new Dictionary<string, string>();
            temp.Add("testKey", "testValue");

            return default;
        }
    }
}