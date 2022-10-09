using Application.Dto;
using AutoMapper;
using Domain.Ingredients;
using Domain.Recipes;

namespace Application.Converters;

public class RecipeSubstituteConverter : ITypeConverter<RecipeSubstituteDto, RecipeSubstitute>
{
    private readonly IMapper _mapper;

    public RecipeSubstituteConverter(IMapper mapper)
    {
        _mapper = mapper;
    }

    public RecipeSubstitute Convert(RecipeSubstituteDto source, RecipeSubstitute destination, ResolutionContext context)
    {
        var measurement = _mapper.Map<Measurement>(source.Measurement);
        var tags = _mapper.Map<IEnumerable<Tag>>(source.Tags);

        return RecipeSubstitute.Create(
            measurement,
            source.Name,
            source.Description,
            source.SubstitutionPrecision,
            tags);
    }
}