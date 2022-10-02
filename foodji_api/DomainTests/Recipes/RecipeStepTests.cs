using Domain;
using Domain.Recipes;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class RecipeStepTests
    {
        [Test]
        public void GivenValidValues_Create_ReturnsRecipeSteps()
        {
            // Arrange
            string expectedContent = "expectedContent";
            int expectedIndex = 1;
            
            // Act
            RecipeStep actualRecipeStep = RecipeStep.Create(expectedContent, expectedIndex);

            // Assert
            actualRecipeStep.Content.Should().Be(expectedContent);
            actualRecipeStep.Index.Should().Be(expectedIndex);
            actualRecipeStep.Should().BeOfType<RecipeStep>();

        }
        
        [Test]
        public void NullContent_Create_ThrowsDomainException()
        {
            // Arrange
            string? expectedContent = null;
            int expectedIndex = 1;
            
            // Act
            var act = () => RecipeStep.Create(expectedContent, expectedIndex);

            // Assert
            act.Should().Throw<DomainException>();
        }
        
        [Test]
        public void EmptyContent_Create_ThrowsDomainException()
        {
            // Arrange
            string expectedContent = "";
            int expectedIndex = 1;
            
            // Act
            var act = () => RecipeStep.Create(expectedContent, expectedIndex);

            // Assert
            act.Should().Throw<DomainException>();
        }
        
        [Test]
        public void InvalidIndex_Create_ThrowsDomainException()
        {
            // Arrange
            string expectedContent = "expectedContent";
            int expectedIndex = -1;
            
            // Act
            var act = () => RecipeStep.Create(expectedContent, expectedIndex);

            // Assert
            act.Should().Throw<DomainException>();
        }
    }
}