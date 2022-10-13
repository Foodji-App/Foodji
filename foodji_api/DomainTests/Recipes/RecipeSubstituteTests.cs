using Domain;
using Domain.Ingredients;
using Domain.Recipes;
using FluentAssertions;
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
            var expectedMeasurement = Measurement.Create(
                UnitType.Cup,
                String.Empty,
                value: 1);
            var expectedName = "expectedName";
            var expectedTags = new List<Tag> { Tag.Vegan, Tag.Vegetarian };
            var expectedSubstitutionPrecisions = "expectedSubstitutionPrecisions";
            
            // Act
            var actualRecipeSubstitute = RecipeSubstitute.Create(
                expectedName,
                expectedSubstitutionPrecisions,
                expectedDescription,
                expectedMeasurement,
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
        public void GivenValidTagInEmptyList_AddTag_TagAddedToList()
        {
            // Arrange
            var tag = Tag.Create("vegan");

            var recipeSubstitute = RecipeSubstitute.Create(
                "substituteName",
                "substitutionPrecisions",
                "description",
                Measurement.Create(
                    UnitType.Cup,
                    String.Empty,
                    1),
                new List<Tag>());
            
            // Act
            recipeSubstitute.AddTag(tag);
            
            // Assert
            recipeSubstitute.Tags.Should().BeEquivalentTo(new List<Tag> { tag });
        }
        
        [Test]
        public void GivenValidTagInPopulatedList_AddTag_TagAddedToList()
        {
            // Arrange
            var tagVegan = Tag.Create("vegan");
            var tagHalal = Tag.Create("halal");

            var recipeSubstitute = RecipeSubstitute.Create(
                "substituteName",
                "substitutionPrecisions",
                "description",
                Measurement.Create(
                    UnitType.Cup,
                    String.Empty,
                    1),
                new List<Tag> { tagVegan });
            
            // Act
            recipeSubstitute.AddTag(tagHalal);

            // Assert
            recipeSubstitute.Tags.Should().BeEquivalentTo(new List<Tag> { tagVegan, tagHalal });
        }
        
        [Test]
        public void GivenValidTagAlreadyInList_AddTag_ThrowsDomainException()
        {
            // Arrange
            var tag = Tag.Create("vegan");
            
            var recipeSubstitute = RecipeSubstitute.Create(
                "substituteName",
                "substitutionPrecisions",
                "description",
                Measurement.Create(
                    UnitType.Cup,
                    String.Empty,
                    1),
                new List<Tag> { tag });
            
            // Act
            var act = () => recipeSubstitute.AddTag(tag);

            // Assert
            act.Should().Throw<DomainException>();
        }
    }
}