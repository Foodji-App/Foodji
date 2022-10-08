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
            var expectedContent = "expectedContent";
            var expectedIndex = 1;
            
            // Act
            var actualRecipeStep = RecipeStep.Create(expectedContent, expectedIndex);

            // Assert
            actualRecipeStep.Content.Should().Be(expectedContent);
            actualRecipeStep.Index.Should().Be(expectedIndex);
            actualRecipeStep.Should().BeOfType<RecipeStep>();

        }
        
        [Test]
        public void NullContent_Create_ThrowsDomainException()
        {
            // Arrange
            string? content = null;
            int index = 1;
            
            // Act
            var act = () => RecipeStep.Create(content, index);

            // Assert
            act.Should().Throw<DomainException>();
        }
        
        [Test]
        public void EmptyContent_Create_ThrowsDomainException()
        {
            // Arrange
            var content = "";
            var index = 1;
            
            // Act
            var act = () => RecipeStep.Create(content, index);

            // Assert
            act.Should().Throw<DomainException>();
        }
        
        [Test]
        public void InvalidIndex_Create_ThrowsDomainException()
        {
            // Arrange
            var content = "expectedContent";
            var index = -1;
            
            // Act
            var act = () => RecipeStep.Create(content, index);

            // Assert
            act.Should().Throw<DomainException>();
        }
    }
}