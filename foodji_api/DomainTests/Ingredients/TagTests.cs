using Domain.Ingredients;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Ingredients;

[TestFixture]
public class TagTests
{
    [Test]
    public void Create_ReturnsTag()
    {
        // Arrange
        var name = "name";
        
        // Act
        var result = Tag.Create(name);
        
        // Assert
        result.Name.Should().Be(name);
    }
}