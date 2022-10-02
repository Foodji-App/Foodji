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
    public void GivenNoCollections_Create_CollectionsAreInitialized()
    {
        // Arrange
        var name = "TestName";
        
        // Act
        var result = Ingredient.Create(name);
        
        // Assert
        result.Tags.Should().NotBeNull().And.BeEmpty();
        result.Substitutes.Should().NotBeNull().And.BeEmpty();
    }

    [Test]
    public void GivenValidSubstituteInEmptyList_AddSubstitute_SubstituteAddedToList()
    {
        // Arrange
        var substitute = Substitute.Create("subName");
        var ingredient = Ingredient.Create("ingredientName");
        
        // Act
        ingredient.AddSubstitute(substitute);
        
        // Assert
        ingredient.Substitutes.Should().BeEquivalentTo(new List<Substitute> { substitute });
    }
    
    [Test]
    public void GivenDuplicateSubstitute_AddSubstitute_SubstituteAddedToList()
    {
        // Arrange
        var substitute = Substitute.Create("subName");
        var ingredient = Ingredient.Create("ingredientName", substitutes: new List<Substitute> { substitute });
        
        // Act
        var act = () => ingredient.AddSubstitute(substitute);

        // Assert
        act.Should().Throw<DomainException>();
    }
}