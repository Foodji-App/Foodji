using Domain;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes;

[TestFixture]
public class UnitTypeTests
{
    [Test]
    public void ValidName_Create_ReturnsUnitType()
    {
        // Arrange
        var expectedName = "unit";
        
        // Act
        var result = UnitType.Create(expectedName);
        
        // Assert
        result.Name.Should().Be(expectedName);
    }
    
    [Test]
    public void InvalidName_Create_ThrowsDomainException()
    {
        // Arrange
        var unexpectedname = "unexpectedName";
        
        // Act
        var act = () => UnitType.Create(unexpectedname);

            // Assert
        act.Should().Throw<DomainException>();
    }
}