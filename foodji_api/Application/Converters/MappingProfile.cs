﻿using Application.Dto;
using AutoMapper;
using Domain.Ingredients;
using Domain.Recipes;
using Domain.Users;

namespace Application.Converters;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<Recipe, RecipeDto>();
        CreateMap<RecipeDto, Recipe>()
            .ConvertUsing<RecipeConverter>();
        
        CreateMap<RecipeCategory, string>()
            .ConvertUsing(x => x.Name);
        CreateMap<string, RecipeCategory>()
            .ConvertUsing(x => RecipeCategory.Create(x));
        
        CreateMap<RecipeDetails, RecipeDetailsDto>();
        CreateMap<RecipeDetailsDto, RecipeDetails>()
            .ConvertUsing(x => RecipeDetails.Create(x.CookingTime, x.PreparationTime, x.RestingTime, x.Serves));

        CreateMap<RecipeIngredient, RecipeIngredientDto>();
        CreateMap<RecipeIngredientDto, RecipeIngredient>()
            .ConvertUsing<RecipeIngredientConverter>();
        
        CreateMap<RecipeSubstitute, RecipeSubstituteDto>();
        CreateMap<RecipeSubstituteDto, RecipeSubstitute>()
            .ConvertUsing<RecipeSubstituteConverter>();
    
        CreateMap<Tag, string>()
            .ConvertUsing(x => x.Name);
        CreateMap<string, Tag>()
            .ConvertUsing(x => Tag.Create(x));
        
        CreateMap<Measurement, MeasurementDto>();
        CreateMap<MeasurementDto, Measurement>()
            .ConvertUsing(x => Measurement.Create(
                x.Value ?? 0,
                !String.IsNullOrEmpty(x.UnitType) ? UnitType.Create(x.UnitType) : UnitType.Unit,
                x.AlternativeText ?? ""));
        
        CreateMap<UnitType, string>()
           .ConvertUsing(x => x.Name);
        CreateMap<string, UnitType>()
           .ConvertUsing(x => UnitType.Create(x));

        CreateMap<UserData, UserDataDto>();
        CreateMap<UserDataDto, UserData>()
            .ConvertUsing(x => UserData.Create(x.Id, x.Recipes));
    }
}