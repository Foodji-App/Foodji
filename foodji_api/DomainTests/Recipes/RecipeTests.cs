using Domain.Ingredients;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class RecipeTests
    {
        [Test]
        public void GivenValidValues_Create_ReturnsRecipe()
        {
            // Arrange ingredient
            var expectedIngredient = RecipeIngredient.Create(
                Measurement.Create(
                    UnitType.Gram,
                    String.Empty,
                    2),
                "expectedIngredientName",
                "expectedIngredientDescription",
                new List<Tag>(),
                new List<RecipeSubstitute>());

            // Arrange recipe
            var expectedName = "expectedName";
            var expectedCreatedAt = new DateTime(2020, 1, 1);
            var expectedCategory = RecipeCategory.Appetizer;
            var expectedDescription = "expectedDescription";
            var expectedDetails = RecipeDetails.Create(0,0,0,0);
            var expectedRecipeIngredients = new List<RecipeIngredient> { expectedIngredient };
            var expectedRecipeSteps = new List<string> { "expectedStep" };
            var expectedImageUri = new Uri("https://www.google.ca"); // Copilot proposed me this lol
            
            // Act
            var actualRecipe = Recipe.Create(
                expectedName,
                expectedCategory,
                expectedDescription,
                expectedDetails,
                expectedRecipeIngredients,
                expectedRecipeSteps,
                expectedImageUri);

            // Assert
            actualRecipe.Name.Should().Be(expectedName);
            actualRecipe.Category.Should().Be(expectedCategory);
            actualRecipe.Description.Should().Be(expectedDescription);
            actualRecipe.Details.Should().Be(expectedDetails);
            actualRecipe.Ingredients.Should().BeEquivalentTo(expectedRecipeIngredients);
            actualRecipe.Steps.Should().BeEquivalentTo(expectedRecipeSteps);
            actualRecipe.ImageUri.Should().Be(expectedImageUri);
            actualRecipe.Should().BeOfType<Recipe>();
        }
    }
}