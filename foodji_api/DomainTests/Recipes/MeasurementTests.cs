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
            var expectedAlternativeText = "expectedAlternativeText";
            var expectedUnitType = UnitType.Gram;
            var expectedValue = 10;
            
            // Act
            var actualMeasurement = Measurement.Create(
                expectedUnitType, expectedAlternativeText, expectedValue);

            // Assert
            actualMeasurement.UnitType.Should().Be(expectedUnitType);
            actualMeasurement.AlternativeText.Should().Be(expectedAlternativeText);
            actualMeasurement.Value.Should().Be(expectedValue);
            actualMeasurement.Should().BeOfType<Measurement>();
        }
        
        [Test]
        public void GivenInvalidAlternativeText_Create_ReturnsMeasurement()
        {
            // Arrange
            var expectedAlternativeText = String.Empty;
            var expectedUnitType = UnitType.Gram;
            var expectedValue = 10;
            
            // Act
            var actualMeasurement = Measurement.Create(
                expectedUnitType, expectedAlternativeText, expectedValue);

            // Assert
            actualMeasurement.UnitType.Should().Be(expectedUnitType);
            actualMeasurement.AlternativeText.Should().Be(expectedAlternativeText);
            actualMeasurement.Value.Should().Be(expectedValue);
            actualMeasurement.Should().BeOfType<Measurement>();
        }
        
                
        [Test]
        public void GivenInvalidValue_Create_ReturnsMeasurement()
        {
            // Arrange
            var expectedAlternativeText = "expectedAlternativeText";
            var expectedUnitType = UnitType.Gram;
            var expectedValue = 0;
            
            // Act
            var actualMeasurement = Measurement.Create(
                expectedUnitType, expectedAlternativeText, expectedValue);

            // Assert
            actualMeasurement.UnitType.Should().Be(expectedUnitType);
            actualMeasurement.AlternativeText.Should().Be(expectedAlternativeText);
            actualMeasurement.Value.Should().Be(expectedValue);
            actualMeasurement.Should().BeOfType<Measurement>();
        }

        [Test]
        public void GivenInvalidValueAlternativeText_Create_ThrowsDomainException()
        {
            // Arrange
            var expectedAlternativeText = "";
            var expectedUnitType = UnitType.Cup;
            var expectedValue = 0;
            
            // Act
            var act = () => Measurement.Create(
                expectedUnitType, expectedAlternativeText, expectedValue);

            // Assert
            act.Should().Throw<DomainException>();
        }
    }
}