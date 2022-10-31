using Domain.Ingredients;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class RecipeTests
    {
        private Recipe _recipe = null!;
        
        [SetUp]
        public void Init()
        {
            var ingredient = RecipeIngredient.Create(
                "ingredientName",
                "ingredientDescription",
                Measurement.Create(
                    2,
                    UnitType.Gram,
                    "alternative text"),
                new List<Tag>(),
                new List<RecipeSubstitute>());

            _recipe = Recipe.Create(
                "name",
                RecipeCategory.Appetizer,
                "description",
                RecipeDetails.Create(0,0,0,0),
                new List<RecipeIngredient> { ingredient },
                new List<string> { "recipeStep" },
                new Uri("https://www.google.ca"),
                "author");
        }
        
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
                    string.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());

            // Arrange recipe
            var expectedName = "expectedName";
            var expectedCategory = RecipeCategory.Appetizer;
            var expectedDescription = "expectedDescription";
            var expectedDetails = RecipeDetails.Create(0,0,0,0);
            var expectedIngredients = new List<RecipeIngredient> { expectedIngredient };
            var expectedRecipeSteps = new List<string> { "expectedStep" };
            var expectedImageUri = new Uri("https://www.google.ca");
            var expectedAuthor = "expectedAuthor";

            // Act
            var actualRecipe = Recipe.Create(
                expectedName,
                expectedCategory,
                expectedDescription,
                expectedDetails,
                expectedIngredients,
                expectedRecipeSteps,
                expectedImageUri,
                expectedAuthor);

            // Assert
            actualRecipe.Name.Should().Be(expectedName);
            actualRecipe.Category.Should().Be(expectedCategory);
            actualRecipe.Description.Should().Be(expectedDescription);
            actualRecipe.Details.Should().Be(expectedDetails);
            actualRecipe.Ingredients.Should().BeEquivalentTo(expectedIngredients);
            actualRecipe.Steps.Should().BeEquivalentTo(expectedRecipeSteps);
            actualRecipe.ImageUri.Should().Be(expectedImageUri);
            actualRecipe.Author.Should().Be(expectedAuthor);
            actualRecipe.Should().BeOfType<Recipe>();
        }

        [Test]
        public void GivenValidRecipeToUpdate_UpdateRecipe_RecipeUpdated()
        {
            // Arrange new substitute
            var substitute = RecipeSubstitute.Create(
                "updatedSubstituteName",
                "updatedSubstituteDescription",
                "substituteDescription",
                Measurement.Create(
                    1,
                    UnitType.Millilitre,
                    "updated alternative text"),
                new List<Tag> { Tag.Vegan });
                
            // Arrange new ingredient
            var ingredient = RecipeIngredient.Create(
                "updatedIngredientName",
                "updatedIngredientDescription",
                Measurement.Create(
                    2,
                    UnitType.Gram,
                    "updated alternative text"),
                new List<Tag> { Tag.Vegan },
                new List<RecipeSubstitute> { substitute });

            // Arrange new recipe
            var expectedRecipe = Recipe.Create(
                "expectedName",
                RecipeCategory.Dessert,
                "expectedDescription",
                RecipeDetails.Create(1,1,1,1),
                new List<RecipeIngredient> { ingredient },
                new List<string> { "updatedRecipeStep" },
                new Uri("https://www.yahoo.ca"),
                "updatedAuthor");
            
            // Act
            _recipe.Update(expectedRecipe);
            
            // Assert
            // I know we should be testing the Id here,
            // but I'm not sure how to do that since Create() does not instantiate the Id property...
            _recipe.Name.Should().Be(expectedRecipe.Name);
            _recipe.Category.Should().Be(expectedRecipe.Category);
            _recipe.Description.Should().Be(expectedRecipe.Description);
            _recipe.Details.Should().Be(expectedRecipe.Details);
            _recipe.Ingredients.Should().BeEquivalentTo(expectedRecipe.Ingredients);
            _recipe.Steps.Should().BeEquivalentTo(expectedRecipe.Steps);
            _recipe.ImageUri.Should().Be(expectedRecipe.ImageUri);
            _recipe.Author.Should().NotBe(expectedRecipe.Author);
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
                    string.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());
            
            var recipe = Recipe.Create(
                "recipeName",
                RecipeCategory.Appetizer,
                "recipeDescription",
                RecipeDetails.Create(0,0,0,0),
                new List<RecipeIngredient>(),
                new List<string>(),
                new Uri("https://www.google.ca"),
                "authorId");
            
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
                    string.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());
            
            var recipe = Recipe.Create(
                "recipeName",
                RecipeCategory.Appetizer,
                "recipeDescription",
                RecipeDetails.Create(0,0,0,0),
                new List<RecipeIngredient> { ingredient },
                new List<string>(),
                new Uri("https://www.google.ca"),
                "authorId");
            
            // Act
            recipe.AddIngredient(ingredient);
            
            // Assert
            recipe.Ingredients.Should().BeEquivalentTo(
                new List<RecipeIngredient> { ingredient, ingredient });
        }
    }
}