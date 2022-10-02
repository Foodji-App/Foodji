using Domain.Ingredients;
using Domain.Recipes;
using FluentAssertions;
using Moq;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class RecipeSubstituteTests
    {
        [Test]
        public void GivenValidValues_Create_ReturnsRecipeSubstitute()
        {
            // Arrange ingredient
            var expectedDescription = "expectedDescription";
            var expectedMeasurement = Measurement.Create(UnitType.Cup, value: 1);
            var expectedName = "expectedName";
            var expectedTags = new List<Tag> { Tag.Vegan, Tag.Vegetarian };
            var expectedSubstitutionPrecisions = "expectedSubstitutionPrecisions";
            
            // Act
            var actualRecipeSubstitute = RecipeSubstitute.Create(
                expectedMeasurement,
                expectedName,
                expectedDescription,
                expectedSubstitutionPrecisions,
                expectedTags);

            // Assert
            actualRecipeSubstitute.Description.Should().Be(expectedDescription);
            actualRecipeSubstitute.Measurement.Should().BeEquivalentTo(expectedMeasurement);
            actualRecipeSubstitute.Name.Should().Be(expectedName);
            actualRecipeSubstitute.SubstitutionPrecisions.Should().Be(expectedSubstitutionPrecisions);
            actualRecipeSubstitute.Tags.Should().BeEquivalentTo(expectedTags);
            actualRecipeSubstitute.Should().BeOfType<RecipeSubstitute>();
        }
        
        [Test]
        public void NoTagNoSubstitutes_Create_ReturnsRecipeIngredient()
        {
            // Arrange ingredient
            var expectedDescription = "expectedDescription";
            var expectedMeasurement = Measurement.Create(UnitType.Cup, value: 1);
            var expectedName = "expectedName";
            var expectedSubstitutionPrecisions = "expectedSubstitutionPrecisions";

            // Act
            var actualRecipeSubstitute = RecipeSubstitute.Create(
                expectedMeasurement,
                expectedName,
                expectedDescription,
                expectedSubstitutionPrecisions);

            // Assert
            actualRecipeSubstitute.Tags.Should().NotBeNull().And.BeEmpty();
            actualRecipeSubstitute.Should().BeOfType<RecipeSubstitute>();
        }
    }
}