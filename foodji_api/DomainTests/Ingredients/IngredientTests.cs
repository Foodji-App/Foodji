using Domain.Ingredients;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Ingredients;

[TestFixture]
public class IngredientTests
{
    [Test]
    public void GivenValidValues_Create_ReturnsIngredient()
    {
        // Arrange
        var name = "TestName";
        var tags = new List<Tag> { Tag.Vegan, Tag.Vegetarian, Tag.LactoseFree };
        var substitutes = new List<Substitute>()
        {
            Substitute.Create(
                "subName",
                new List<Tag> { Tag.Vegan, Tag.Vegetarian, Tag.LactoseFree },
                substitutionPrecisions: "testPrecisions")
        };
        
        // Act
        var result = Ingredient.Create(name, tags, substitutes);
        
        // Assert
        result.Name.Should().Be(name);
        result.Tags.Should().BeEquivalentTo(tags);
        result.Substitutes.Should().BeEquivalentTo(substitutes);
    }

    [Test]
    public void GivenValidSubstituteInEmptyList_AddSubstitute_SubstituteAddedToList()
    {
        // Arrange
        var substitute = Substitute.Create(
            "subName",
            new List<Tag>(),
            substitutionPrecisions: "testPrecisions");
        var ingredient = Ingredient.Create(
            "ingredientName",
            new List<Tag>(),
            new List<Substitute>());
        
        // Act
        ingredient.AddSubstitute(substitute);
        
        // Assert
        ingredient.Substitutes.Should().BeEquivalentTo(new List<Substitute> { substitute });
    }
}