using Application.Dto;
using Microsoft.AspNetCore.Authorization;

namespace Auth.Policies;

public class FoodjiAuthorizationHandler : AuthorizationHandler<FoodjiRecipeAccessRequirement, RecipeAccessRightsDto>
{
    protected override Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        FoodjiRecipeAccessRequirement requirement,
        RecipeAccessRightsDto recipe)
    {
        // Precheck which automatically grants access if the user has an admin claim
        if (context.User.HasClaim(x => x.Type == "admin" && x.Value == "true"))
        {
            context.Succeed(requirement);
        }
        
        // Extract user id
        var authorId = context.User.Claims.First(x => x.Type == "user_id").Value;

        if (authorId == recipe.AuthorId)
        {
            context.Succeed(requirement);
        }
        
        return Task.CompletedTask;
    }
}