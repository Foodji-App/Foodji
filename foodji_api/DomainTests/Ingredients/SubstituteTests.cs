using Domain.Ingredients;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Ingredients;

[TestFixture]
public class SubstituteTests
{
    [Test]
    public void GivenValidValues_Create_ReturnsSubstitute()
    {
        // Arrange
        var name = "TestName";
        var tags = new List<Tag> { Tag.Vegan, Tag.Vegetarian, Tag.LactoseFree };
        var substitutionPrecisions = "precisions";
        
        // Act
        var result = Substitute.Create(name, substitutionPrecisions, tags);
        
        // Assert
        result.Name.Should().Be(name);
        result.Tags.Should().BeEquivalentTo(tags);
        result.SubstitutionPrecisions.Should().Be(substitutionPrecisions);
    }
}