using Application.Dto;
using AutoMapper;
using Domain.Recipes;
using Infra;
using MediatR;
using MongoDB.Driver;

namespace Application.Queries;

public class GetAllRecipesFromUserQuery : IRequest<IEnumerable<RecipeDto>>
{
    private string AuthorId { get; }

    public GetAllRecipesFromUserQuery(string authorId)
    {
        AuthorId = authorId;
    }
    
    private class Handler : IRequestHandler<GetAllRecipesFromUserQuery, IEnumerable<RecipeDto>>
    {
        private readonly IFoodjiDbClient _client;
        private readonly IMapper _mapper;

        public Handler(IFoodjiDbClient client, IMapper mapper)
        {
            _client = client;
            _mapper = mapper;
        }

        public async Task<IEnumerable<RecipeDto>> Handle(
            GetAllRecipesFromUserQuery request, 
            CancellationToken cancellationToken)
        {
            var results = await _client.Recipes.FindAsync(
                x => x.Author == request.AuthorId, cancellationToken: cancellationToken);
            
            return _mapper.Map<IEnumerable<Recipe>, IEnumerable<RecipeDto>>(
                results.ToList(cancellationToken: cancellationToken));
        }
    }
}