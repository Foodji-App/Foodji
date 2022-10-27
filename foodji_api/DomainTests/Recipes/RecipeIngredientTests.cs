using Domain;
using Domain.Ingredients;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class RecipeIngredientTests
    {
        [Test]
        public void GivenValidValues_Create_ReturnsRecipeIngredient()
        {
            // Arrange substitution
            var expectedRecipeSubstitute = RecipeSubstitute.Create(
                "expectedSubstituteName",
                "substitutionPrecisions",
                "expectedSubstituteDescription",
                Measurement.Create(
                    2,
                    UnitType.Gram,
                    String.Empty),
                new List<Tag>());

            // Arrange ingredient
            var expectedDescription = "expectedDescription";
            var expectedMeasurement = Measurement.Create(
                1,
                UnitType.Cup,
                String.Empty);
            var expectedName = "expectedName";
            var expectedRecipeSubstitutes = new List<RecipeSubstitute> { expectedRecipeSubstitute };
            var expectedTags = new List<Tag> { Tag.Vegan, Tag.Vegetarian };

            // Act
            var actualRecipeIngredient = RecipeIngredient.Create(
                expectedName,
                expectedDescription,
                expectedMeasurement,
                expectedTags,
                expectedRecipeSubstitutes);

            // Assert
            actualRecipeIngredient.Description.Should().Be(expectedDescription);
            actualRecipeIngredient.Measurement.Should().BeEquivalentTo(expectedMeasurement);
            actualRecipeIngredient.Name.Should().Be(expectedName);
            actualRecipeIngredient.RecipeSubstitutes.Should().BeEquivalentTo(expectedRecipeSubstitutes);
            actualRecipeIngredient.Tags.Should().BeEquivalentTo(expectedTags);
            actualRecipeIngredient.Should().BeOfType<RecipeIngredient>();
        }
        
        [Test]
        public void GivenValidTagInEmptyList_AddTag_TagAddedToList()
        {
            // Arrange
            var tag = Tag.Create("vegan");
            
            var recipeIngredient = RecipeIngredient.Create(
                "ingredientName",
                "description",
                Measurement.Create(
                    1,
                    UnitType.Cup,
                    String.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());
            
            // Act
            recipeIngredient.AddTag(tag);
            
            // Assert
            recipeIngredient.Tags.Should().BeEquivalentTo(new List<Tag> { tag });
        }
        
        [Test]
        public void GivenValidTagInPopulatedList_AddTag_TagAddedToList()
        {
            // Arrange
            var tagVegan = Tag.Create("vegan");
            var tagHalal = Tag.Create("halal");

            var recipeIngredient = RecipeIngredient.Create(
                "ingredientName",
                "description",
                Measurement.Create(
                    1,
                    UnitType.Cup,
                    String.Empty),
                new List<Tag> { tagVegan },
                new List<RecipeSubstitute>());
            
            // Act
            recipeIngredient.AddTag(tagHalal);

            // Assert
            recipeIngredient.Tags.Should().BeEquivalentTo(new List<Tag> { tagVegan, tagHalal });
        }
        
        [Test]
        public void GivenValidTagAlreadyInList_AddTag_ThrowsDomainException()
        {
            // Arrange
            var tag = Tag.Create("vegan");
            
            var recipeIngredient = RecipeIngredient.Create(
                "ingredientName",
                "description",
                Measurement.Create(
                    1,
                    UnitType.Cup,
                    String.Empty),
                new List<Tag> { tag },
                new List<RecipeSubstitute>());
            
            // Act
            var act = () => recipeIngredient.AddTag(tag);

            // Assert
            act.Should().Throw<DomainException>();
        }

        [Test]
        public void GivenValidSubstituteInEmptyList_AddSubstitute_SubstituteAddedToList()
        {
            // Arrange
            var recipeSubstitute = RecipeSubstitute.Create(
                "name",
                "substitutionPrecisions",
                "description",
                Measurement.Create(
                    1,
                    UnitType.Cup,
                    String.Empty),
                new List<Tag>());
            
            var recipeIngredient = RecipeIngredient.Create(
                "ingredientName",
                "description",
                Measurement.Create(
                    1,
                    UnitType.Cup,
                    String.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute>());
            
            // Act
            recipeIngredient.AddSubstitute(recipeSubstitute);
            
            // Assert
            recipeIngredient.RecipeSubstitutes.Should().BeEquivalentTo(
                new List<RecipeSubstitute> { recipeSubstitute });
        }
        
        [Test]
        public void GivenValidSubstituteInPopulatedList_AddSubstitute_SubstituteAddedToList()
        {
            // Arrange
            var recipeSubstitute = RecipeSubstitute.Create(
                "name",
                "substitutionPrecisions",
                "description",
                Measurement.Create(
                    1,
                    UnitType.Cup,
                    String.Empty),
                new List<Tag>());
            
            var recipeIngredient = RecipeIngredient.Create(
                "ingredientName",
                "description",
                Measurement.Create(
                    1,
                    UnitType.Cup,
                    String.Empty),
                new List<Tag>(),
                new List<RecipeSubstitute> { recipeSubstitute });
            
            // Act
            recipeIngredient.AddSubstitute(recipeSubstitute);
            
            // Assert
            recipeIngredient.RecipeSubstitutes.Should().BeEquivalentTo(
                new List<RecipeSubstitute> { recipeSubstitute, recipeSubstitute });
        }
    }
}