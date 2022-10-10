using Domain.Recipes;
using Infra;
using MediatR;
using MongoDB.Driver;

namespace Application.Queries;

public class GetAllRecipesQuery : IRequest<IEnumerable<Recipe>>
{
    private class Handler : IRequestHandler<GetAllRecipesQuery, IEnumerable<Recipe>>
    {
        private readonly IFoodjiDbClient _client;

        public Handler(IFoodjiDbClient client)
        {
            _client = client;
        }


        public async Task<IEnumerable<Recipe>> Handle(GetAllRecipesQuery request, CancellationToken cancellationToken)
        {
            var recipes = 
                await _client.Recipes.FindAsync(_ => true, cancellationToken: cancellationToken);
            
            return recipes.ToList(cancellationToken);
        }
    }
}