using Domain;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class RecipeDetailsTests
    {
        [Test]
        public void GivenValidValues_Create_ReturnsRecipeDetails()
        {
            // Arrange
            int expectedCookingTime = 10;
            int expectedPreparationTime = 20;
            int expectedRestingTime = 30;
            int expectedServes = 4;
            
            // Act
            RecipeDetails actualRecipeDetails = RecipeDetails.Create(
                expectedCookingTime,
                expectedPreparationTime,
                expectedRestingTime,
                expectedServes);

            // Assert
            actualRecipeDetails.CookingTime.Should().Be(expectedCookingTime);
            actualRecipeDetails.PreparationTime.Should().Be(expectedPreparationTime);
            actualRecipeDetails.RestingTime.Should().Be(expectedRestingTime);
            actualRecipeDetails.Serves.Should().Be(expectedServes);
            actualRecipeDetails.TotalTime.Should().Be(
                expectedCookingTime + expectedPreparationTime + expectedRestingTime);
            actualRecipeDetails.Should().BeOfType<RecipeDetails>();
        }
        
        [Test]
        public void NoValues_Create_ReturnsRecipeDetails()
        {
            // Arrange
            int expectedValue = 0;
            
            // Act
            RecipeDetails actualRecipeDetails = RecipeDetails.Create();

            // Assert
            actualRecipeDetails.CookingTime.Should().Be(expectedValue);
            actualRecipeDetails.PreparationTime.Should().Be(expectedValue);
            actualRecipeDetails.RestingTime.Should().Be(expectedValue);
            actualRecipeDetails.Serves.Should().Be(expectedValue);
            actualRecipeDetails.TotalTime.Should().Be(
                expectedValue);
            actualRecipeDetails.Should().BeOfType<RecipeDetails>();
        }
    }
}