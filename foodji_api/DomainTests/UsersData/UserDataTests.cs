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
        
        [Test]
        public void GivenValidRecipeId_AddRecipe_RecipeAddedToList()
        {
            // Arrange
            var userDataId = "UserDataId";
            var expectedRecipe = "Recipe1";
            var userData = UserData.Create(
                userDataId,
                new List<string>());

            // Act
            userData.AddRecipe(expectedRecipe);
            
            // Assert
            userData.Recipes.First().Should().BeEquivalentTo(expectedRecipe);
        }
        
        [Test]
        public void GivenDuplicateRecipeId_AddRecipe_RecipeNotAddedToList()
        {
            // Arrange
            var userDataId = "UserDataId";
            var expectedRecipe = "Recipe1";
            var userData = UserData.Create(
                userDataId,
                new List<string> {expectedRecipe});

            // Act
            userData.AddRecipe(expectedRecipe);
            
            // Assert
            userData.Recipes.Count().Should().Be(1);
        }
        
        [Test]
        public void GivenValidRecipeId_Remove_RecipeRemovedFromList()
        {
            // Arrange
            var userDataId = "UserDataId";
            var userData = UserData.Create(
                userDataId,
                new List<string> {"Recipe1", "Recipe2"});
            var expectedRecipes = new List<string> {"Recipe1"} ;
            var recipeToRemove = "Recipe2";

            // Act
            userData.RemoveRecipe(recipeToRemove);
            
            // Assert
            userData.Recipes.Should().BeEquivalentTo(expectedRecipes);
        }
        
        [Test]
        public void GivenInvalidRecipeId_Remove_RecipeNotRemovedFromList()
        {
            // Arrange
            var userDataId = "UserDataId";
            var expectedRecipes = new List<string> { "Recipe1"};
            var recipeToRemove = "Recipe2";
            var userData = UserData.Create(
                userDataId,
                expectedRecipes);

            // Act
            userData.RemoveRecipe(recipeToRemove);
            
            // Assert
            userData.Recipes.Should().BeEquivalentTo(expectedRecipes);
        }
    }
}