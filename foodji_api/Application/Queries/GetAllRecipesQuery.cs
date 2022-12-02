using Application.Dto;
using AutoMapper;
using Domain.Recipes;
using Infra;
using MediatR;
using MongoDB.Driver;

namespace Application.Queries;

public class GetAllRecipesQuery : IRequest<IEnumerable<RecipeDto>>
{
    private class Handler : IRequestHandler<GetAllRecipesQuery, IEnumerable<RecipeDto>>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }


        public async Task<IEnumerable<RecipeDto>> Handle(GetAllRecipesQuery request, CancellationToken cancellationToken)
        {
            var recipes = await _client.Recipes.FindAsync(_ => true, cancellationToken: cancellationToken);

            return _mapper.Map<IEnumerable<Recipe>, IEnumerable<RecipeDto>>(recipes.ToList(cancellationToken));
        }
    }
}