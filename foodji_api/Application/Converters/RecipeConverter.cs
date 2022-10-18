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

        var steps = _mapper.Map<IEnumerable<RecipeStepDto>, IEnumerable<RecipeStep>>(source.Steps);

        return Recipe.Create(
            source.Name,
            category,
            source.Description,
            details,
            ingredients,
            steps);
    }
}