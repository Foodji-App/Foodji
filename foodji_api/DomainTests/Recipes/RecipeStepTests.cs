using Domain.Recipes;
using NUnit.Framework;

namespace DomainTests.Recipes
{
    [TestFixture]
    public class RecipeStepTests
    {
        [SetUp]
        public void Setup()
        {
            // TODO - We should call Create() in the setup method if we have to test other methods
        }

        [Test]
        public void Create()
        {
            // Arrange
            String content = "content";
            int index = 1;
            
            // Act
            RecipeStep recipeStep = RecipeStep.Create("content", 1);

            // Assert
            Assert.That(recipeStep.Content, Is.EqualTo(content));
            Assert.True(index == recipeStep.Index);
        }
    }
}