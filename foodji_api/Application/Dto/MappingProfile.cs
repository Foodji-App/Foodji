using AutoMapper;
using Domain.Ingredients;
using Domain.Recipes;

namespace Application.Dto;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<UnitType, string>()
           .ConvertUsing(x => x.Name);
        CreateMap<string, UnitType>()
           .ConvertUsing(x => UnitType.Create(x));
           
        CreateMap<RecipeCategory, string>()
            .ConvertUsing(x => x.Name);
        CreateMap<string, RecipeCategory>()
            .ConvertUsing(x => RecipeCategory.Create(x));

        CreateMap<Tag, string>()
            .ConvertUsing(x => x.Name);
        CreateMap<string, Tag>()
            .ConvertUsing(x => Tag.Create(x));
        
        CreateMap<Measurement, MeasurementDto>();
        CreateMap<MeasurementDto, Measurement>()
            .ConvertUsing(x => Measurement.Create(
                !String.IsNullOrEmpty(x.UnitType) ? UnitType.Create(x.UnitType) : UnitType.Millilitre,
                x.AlternativeText ?? "",
                x.Value ?? 0));
        
        CreateMap<RecipeDetails, RecipeDetailsDto>();
        CreateMap<RecipeDetailsDto, RecipeDetails>();
            // .ConvertUsing(x => 
            //     RecipeDetails.Create(x.CookingTime, x.PreparationTime, x.RestingTime, x.Serves));
        
        CreateMap<RecipeStep, RecipeStepDto>();
        CreateMap<RecipeStepDto, RecipeStep>();
        // .ConvertUsing(x => RecipeStep.Create(x.Content, x.Index));

        CreateMap<RecipeIngredient, RecipeIngredientDto>();
        CreateMap<RecipeIngredientDto, RecipeIngredient>();

        CreateMap<Recipe, RecipeDto>();
        CreateMap<RecipeDto, Recipe>()
            .ConvertUsing<RecipeConverter>();
    }
}

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
        
        // TODO find proper way to *explicitely* map collections
        var ingredients = _mapper.Map<IEnumerable<RecipeIngredient>>(source.Ingredients);
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