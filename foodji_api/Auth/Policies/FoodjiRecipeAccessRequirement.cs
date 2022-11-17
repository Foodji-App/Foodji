using Microsoft.AspNetCore.Authorization;

namespace Auth.Policies;

// TODO this is very generic, and suitable pre-sharing, but should be extended with
// a suite of policies to handle ownership, sharing and admin rights on a variety
// of action (read, update, delete)
public class FoodjiRecipeAccessRequirement : IAuthorizationRequirement
{
    public static readonly string Policy = "ReadRecipePolicy";
}