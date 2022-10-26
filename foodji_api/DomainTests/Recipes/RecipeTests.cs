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
                "expectedIngredientName",
                "expectedIngredientDescription",
                Measurement.Create(
                    2,
                    UnitType.Gram,
                    String.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());

            // Arrange recipe
            var expectedName = "expectedName";
            var expectedCategory = RecipeCategory.Appetizer;
            var expectedDescription = "expectedDescription";
            var expectedDetails = RecipeDetails.Create(0,0,0,0);
            var expectedRecipeIngredients = new List<RecipeIngredient> { expectedIngredient };
            var expectedRecipeSteps = new List<string> { "expectedStep" };
            var expectedImageUri = new Uri("https://www.google.ca");
            
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
        
        [Test]
        public void GivenValidIngredientInEmptyList_AddIngredient_IngredientAddedToList()
        {
            // Arrange
            var ingredient = RecipeIngredient.Create(
                "ingredientName",
                "ingredientDescription",
                Measurement.Create(
                    2,
                    UnitType.Gram,
                    String.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());
            
            var recipe = Recipe.Create(
                "recipeName",
                RecipeCategory.Appetizer,
                "recipeDescription",
                RecipeDetails.Create(0,0,0,0),
                new List<RecipeIngredient>(),
                new List<string>(),
                new Uri("https://www.google.ca"));
            
            // Act
            recipe.AddIngredient(ingredient);
            
            // Assert
            recipe.Ingredients.Should().BeEquivalentTo(
                new List<RecipeIngredient> { ingredient });
        }
        
        [Test]
        public void GivenValidIngredientInPopulatedList_AddIngredient_IngredientAddedToList()
        {
            // Arrange
            var ingredient = RecipeIngredient.Create(
                "ingredientName",
                "ingredientDescription",
                Measurement.Create(
                    2,
                    UnitType.Gram,
                    String.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());
            
            var recipe = Recipe.Create(
                "recipeName",
                RecipeCategory.Appetizer,
                "recipeDescription",
                RecipeDetails.Create(0,0,0,0),
                new List<RecipeIngredient> { ingredient },
                new List<string>(),
                new Uri("https://www.google.ca"));
            
            // Act
            recipe.AddIngredient(ingredient);
            
            // Assert
            recipe.Ingredients.Should().BeEquivalentTo(
                new List<RecipeIngredient> { ingredient, ingredient });
        }
    }
}