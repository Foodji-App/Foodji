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

        // TODO find proper way to *explicitly* map collections
        var ingredients = new List<RecipeIngredient>();
        foreach (var ingredient in source.Ingredients)
        {
            ingredients.Add(_mapper.Map<RecipeIngredient>(ingredient));
        }

        var steps = _mapper.Map<IEnumerable<RecipeStep>>(source.Steps);
        // var details = RecipeDetails.Create(
        //     source?.Details.CookingTime ?? 0,
        //     source?.Details.PreparationTime ?? 0,
        //     source?.Details.RestingTime ?? 0,
        //     source?.Details.Serves ?? 1);

        // TODO mapped types still seem to be nullable, by their var evaluation
        return Recipe.Create(
            source.Name,
            category,
            source.Description,
            details,
            ingredients,
            steps);
    }
}