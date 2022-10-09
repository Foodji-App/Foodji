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
                Measurement.Create(UnitType.Gram, value: 2),
                "expectedSubstituteName",
                "expectedSubstituteDescription");

            // Arrange recipe
            var expectedName = "expectedName";
            var expectedCreatedAt = new DateTime(2020, 1, 1);
            var expectedCategory = RecipeCategory.Appetizer;
            var expectedDescription = "expectedDescription";
            var expectedDetails = RecipeDetails.Create(0,0,0,0);
            var expectedRecipeIngredients = new List<RecipeIngredient> { expectedIngredient };
            var expectedRecipeSteps = new List<RecipeStep> { RecipeStep.Create("expectedStep", 1) };            
            
            // Act
            var actualRecipe = Recipe.Create(
                expectedName,
                expectedCreatedAt,
                expectedCategory,
                expectedDescription,
                expectedDetails,
                expectedRecipeIngredients,
                expectedRecipeSteps);

            // Assert
            actualRecipe.Name.Should().Be(expectedName);
            actualRecipe.CreatedAt.Should().Be(expectedCreatedAt);
            actualRecipe.Category.Should().Be(expectedCategory);
            actualRecipe.Description.Should().Be(expectedDescription);
            actualRecipe.Details.Should().Be(expectedDetails);
            actualRecipe.Ingredients.Should().BeEquivalentTo(expectedRecipeIngredients);
            actualRecipe.Steps.Should().BeEquivalentTo(expectedRecipeSteps);
            actualRecipe.Should().BeOfType<Recipe>();
        }
    }
}