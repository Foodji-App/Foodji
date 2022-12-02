using Application.Dto;
using AutoMapper;
using Domain.Ingredients;
using Domain.Recipes;

namespace Application.Converters;

public class RecipeIngredientConverter : ITypeConverter<RecipeIngredientDto, RecipeIngredient>
{
    private readonly IMapper _mapper;

    public RecipeIngredientConverter(IMapper mapper)
    {
        _mapper = mapper;
    }

    public RecipeIngredient Convert(RecipeIngredientDto source, RecipeIngredient destination, ResolutionContext context)
    {
        var measurement = _mapper.Map<Measurement>(source.Measurement);
        var tags = _mapper.Map<IEnumerable<Tag>>(source.Tags);

        var substitutes = 
            _mapper.Map<IEnumerable<RecipeSubstituteDto>, IEnumerable<RecipeSubstitute>>(source.Substitutes);

        return RecipeIngredient.Create(
            source.Name,
            source.Description,
            measurement,
            tags,
            substitutes);
    }
}