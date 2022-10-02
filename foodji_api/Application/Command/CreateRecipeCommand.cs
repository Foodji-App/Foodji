using Application.Queries;
using MediatR;
using MongoDB.Driver;

namespace Application.Command;

public class CreateRecipeCommand : IRequest
{
    
    
    
    private class Handler : IRequestHandler<CreateRecipeCommand>
    {
        private readonly IMongoClient _client;

        public Handler(IMongoClient client)
        {
            _client = client;
        }
        
        // TODO - copy pasta shenanigans, we have to redo the method
        public async Task<Unit> Handle(CreateRecipeCommand request, CancellationToken cancellationToken)
        {
            var temp = new Dictionary<string, string>();
            temp.Add("testKey", "testValue");
            
            /*await _client.GetDatabase("foodji")
                .GetCollection<Dictionary<string, string>>("test")
                .InsertOneAsync(temp, cancellationToken);*/
            
            return Unit.Value;
        }
    }
}