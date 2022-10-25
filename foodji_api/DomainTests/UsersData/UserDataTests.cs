using Domain;
using Domain.Recipes;
using Domain.Users;
using FluentAssertions;
using NUnit.Framework;

namespace DomainTests.UsersData
{
    [TestFixture]
    public class UserDataTests
    {
        [Test]
        public void GivenValidValues_Create_ReturnsUserData()
        {
            // Arrange
            var expectedId = "expectedId";
            var expectedRecipes = new List<string> { "recipe1", "recipe2" };
            
            // Act
            var actualUserData = UserData.Create(
                expectedId, expectedRecipes);

            // Assert
            actualUserData.Id.Should().Be(expectedId);
            actualUserData.Recipes.Should().BeEquivalentTo(expectedRecipes);
            actualUserData.Should().BeOfType<UserData>();
        }
        
        [Test]
        public void GivenEmptyRecipeList_Create_ReturnsUserData()
        {
            // Arrange
            var expectedId = "expectedId";
            var expectedRecipes = new List<string>();
            
            // Act
            var actualUserData = UserData.Create(
                expectedId, expectedRecipes);

            // Assert
            actualUserData.Id.Should().Be(expectedId);
            actualUserData.Recipes.Should().BeEquivalentTo(expectedRecipes);
            actualUserData.Should().BeOfType<UserData>();
        }
    }
}