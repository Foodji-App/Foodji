using Domain;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class MeasurementTests
    {
        [Test]
        public void GivenValidValues_Create_ReturnsMeasurement()
        {
            // Arrange
            string expectedAlternativeText = "expectedAlternativeText";
            UnitType expectedUnitType = UnitType.Gram;
            decimal expectedValue = 10;
            
            // Act
            Measurement actualMeasurement = Measurement.Create(
                expectedUnitType, expectedAlternativeText, expectedValue);

            // Assert
            actualMeasurement.UnitType.Should().Be(expectedUnitType);
            actualMeasurement.AlternativeText.Should().Be(expectedAlternativeText);
            actualMeasurement.Value.Should().Be(expectedValue);
            actualMeasurement.Should().BeOfType<Measurement>();
        }
        
        [Test]
        public void WithoutAlternativeText_Create_ReturnsMeasurement()
        {
            // Arrange
            string expectedAlternativeText = "";
            UnitType expectedUnitType = UnitType.Gram;
            decimal expectedValue = 10;
            
            // Act
            Measurement actualMeasurement = Measurement.Create(
                expectedUnitType, value: expectedValue);

            // Assert
            actualMeasurement.UnitType.Should().Be(expectedUnitType);
            actualMeasurement.AlternativeText.Should().Be(expectedAlternativeText);
            actualMeasurement.Value.Should().Be(expectedValue);
            actualMeasurement.Should().BeOfType<Measurement>();
        }
        
        [Test]
        public void WithoutValidValue_Create_ReturnsMeasurement()
        {
            // Arrange
            string expectedAlternativeText = "expectedAlternativeText";
            UnitType expectedUnitType = UnitType.Cup;
            decimal expectedValue = 0;
            
            // Act
            Measurement actualMeasurement = Measurement.Create(expectedUnitType, expectedAlternativeText);

            // Assert
            actualMeasurement.UnitType.Should().Be(expectedUnitType);
            actualMeasurement.AlternativeText.Should().Be(expectedAlternativeText);
            actualMeasurement.Value.Should().Be(expectedValue);
            actualMeasurement.Should().BeOfType<Measurement>();
        }
        
        [Test]
        public void Create_invalid_value_alternativeText_ThrowsDomainException()
        {
            // Arrange
            string expectedAlternativeText = "";
            UnitType expectedUnitType = UnitType.Cup;
            decimal expectedValue = 0;
            
            // Act
            var act = () => Measurement.Create(
                expectedUnitType, expectedAlternativeText, expectedValue);

            // Assert
            act.Should().Throw<DomainException>();
        }
    }
}