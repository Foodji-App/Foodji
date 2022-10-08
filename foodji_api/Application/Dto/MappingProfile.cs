using AutoMapper;
using Domain.Ingredients;
using Domain.Recipes;

namespace Application.Dto;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<UnitType, string>();
           // .ConvertUsing(x => x.Name);
           CreateMap<string, UnitType>();
           // .ConvertUsing(x => UnitType.Create(x));
           
        CreateMap<RecipeCategory, string>();
        CreateMap<string, RecipeCategory>();

        CreateMap<Tag, string>();
        CreateMap<string, Tag>();
        
        CreateMap<Measurement, MeasurementDto>();
        CreateMap<MeasurementDto, Measurement>();
           // .ConvertUsing(x => Measurement.Create(UnitType.Create(x.UnitType), x.AlternativeText, x.Value))
        
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
        CreateMap<RecipeDto, Recipe>();
    }
}