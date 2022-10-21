using Domain;
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
                substitutionPrecisions: "testPrecisions",
                new List<Tag> { Tag.Vegan, Tag.Vegetarian, Tag.LactoseFree })
        };
        
        // Act
        var result = Ingredient.Create(name, tags, substitutes);
        
        // Assert
        result.Name.Should().Be(name);
        result.Tags.Should().BeEquivalentTo(tags);
        result.Substitutes.Should().BeEquivalentTo(substitutes);
    }
    
    [Test]
    public void GivenValidTagInEmptyList_AddTag_TagAddedToList()
    {
        // Arrange
        var tag = Tag.Create("vegan");
        var ingredient = Ingredient.Create(
            "ingredientName",
            new List<Tag>(),
            new List<Substitute>());
        
        // Act
        ingredient.AddTag(tag);
        
        // Assert
        ingredient.Tags.Should().BeEquivalentTo(new List<Tag> { tag });
    }
    
    [Test]
    public void GivenValidTagInPopulatedList_AddTag_TagAddedToList()
    {
        // Arrange
        var tagVegan = Tag.Create("vegan");
        var tagHalal = Tag.Create("halal");
        var ingredient = Ingredient.Create(
            "ingredientName",
            new List<Tag> { tagVegan },
            new List<Substitute>());
        
        // Act
        ingredient.AddTag(tagHalal);

        // Assert
        ingredient.Tags.Should().BeEquivalentTo(new List<Tag> { tagVegan, tagHalal });
    }
    
    [Test]
    public void GivenValidTagAlreadyInList_AddTag_ThrowsDomainException()
    {
        // Arrange
        var tag = Tag.Create("vegan");
        var ingredient = Ingredient.Create(
            "ingredientName",
            new List<Tag> { tag },
            new List<Substitute>());
        
        // Act
        var act = () => ingredient.AddTag(tag);

        // Assert
        act.Should().Throw<DomainException>();
    }

    [Test]
    public void GivenValidSubstituteInEmptyList_AddSubstitute_SubstituteAddedToList()
    {
        // Arrange
        var substitute = Substitute.Create(
            "subName",
            "testPrecisions",
            new List<Tag>());
        var ingredient = Ingredient.Create(
            "ingredientName",
            new List<Tag>(),
            new List<Substitute>());
        
        // Act
        ingredient.AddSubstitute(substitute);
        
        // Assert
        ingredient.Substitutes.Should().BeEquivalentTo(new List<Substitute> { substitute });
    }
    
    [Test]
    public void GivenValidSubstituteInPopulatedList_AddSubstitute_SubstituteAddedToList()
    {
        // Arrange
        var substitute = Substitute.Create(
            "subName",
            "testPrecisions",
            new List<Tag>());
        var ingredient = Ingredient.Create(
            "ingredientName",
            new List<Tag>(),
            new List<Substitute> { substitute });
        
        // Act
        ingredient.AddSubstitute(substitute);
        
        // Assert
        ingredient.Substitutes.Should().BeEquivalentTo(new List<Substitute> { substitute, substitute });
    }
}