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
                Measurement.Create(
                    UnitType.Gram,
                    String.Empty,
                    2),
                "expectedSubstituteName",
                "expectedSubstituteDescription",
                "substitutionPrecisions",
                new List<Tag>());

            // Arrange ingredient
            var expectedDescription = "expectedDescription";
            var expectedMeasurement = Measurement.Create(
                UnitType.Cup,
                String.Empty,
                1);
            var expectedName = "expectedName";
            var expectedRecipeSubstitutes = new List<RecipeSubstitute> { expectedRecipeSubstitute };
            var expectedTags = new List<Tag> { Tag.Vegan, Tag.Vegetarian };

            // Act
            var actualRecipeIngredient = RecipeIngredient.Create(
                expectedMeasurement,
                expectedName,
                expectedDescription,
                expectedTags,
                expectedRecipeSubstitutes);

            // Assert
            actualRecipeIngredient.Description.Should().Be(expectedDescription);
            actualRecipeIngredient.Measurement.Should().BeEquivalentTo(expectedMeasurement);
            actualRecipeIngredient.Name.Should().Be(expectedName);
            actualRecipeIngredient.Substitutes.Should().BeEquivalentTo(expectedRecipeSubstitutes);
            actualRecipeIngredient.Tags.Should().BeEquivalentTo(expectedTags);
            actualRecipeIngredient.Should().BeOfType<RecipeIngredient>();
        }
    }
}