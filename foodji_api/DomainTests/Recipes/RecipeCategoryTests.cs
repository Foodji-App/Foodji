﻿using Domain;
using Domain.Ingredients;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes;

[TestFixture]
public class RecipeCategoryTests
{
    [Test]
    public void ValidName_Create_ReturnsRecipeCategory()
    {
        // Arrange
        var expectedName = "dessert";

        // Act
        var result = RecipeCategory.Create(expectedName);

        // Assert
        result.Name.Should().Be(expectedName);
    }

    [Test]
    public void ValidName_Create_ReturnsRecipeCategoryExistingUpperCase()
    {
        // Arrange
        var expectedName = "dessert";
        var creationName = "Dessert";

        // Act
        var result = RecipeCategory.Create(creationName);
        
        // Assert
        result.Name.Should().Be(expectedName);
    }

    [Test]
    public void InvalidName_Create_ThrowsDomainException()
    {
        // Arrange
        var expectedName = "expectedName";
        
        // Act
        var act = () => RecipeCategory.Create(expectedName);

            // Assert
        act.Should().Throw<DomainException>();
    }
}