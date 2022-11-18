using Application.Dto;
using AutoMapper;
using Domain.Recipes;

namespace Application.Converters;

public class RecipeConverter : ITypeConverter<RecipeDto, Recipe>
{
    private readonly IMapper _mapper;

    public RecipeConverter(IMapper mapper)
    {
        _mapper = mapper;
    }

    public Recipe Convert(RecipeDto source, Recipe destination, ResolutionContext context)
    {
        var category = _mapper.Map<RecipeCategory>(source.Category);
        var details = _mapper.Map<RecipeDetails>(source.Details);

        var ingredients = 
            _mapper.Map<IEnumerable<RecipeIngredientDto>, IEnumerable<RecipeIngredient>>(source.Ingredients);

        return Recipe.Create(
            source.Name,
            category,
            source.Description,
            details,
            ingredients,
            source.Steps.ToList(),
            source.ImageUri,
            // Shouldn't happen, as is set from auth context in controller
            source.Author ?? throw new ArgumentException("Author id has not been set"));
    }
}