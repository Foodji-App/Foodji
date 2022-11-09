using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using Microsoft.AspNetCore.Authentication.JwtBearer;

namespace Api.Auth.Extensions;

public static class ServiceCollectionExtension
{
    public static void AddFirebaseJwtAuthentication(this IServiceCollection services, string firebaseCredentials)
    {
        // Needs to be created to use the FirebaseAuth.DefaultInstance later, in the handler
        FirebaseApp.Create(new AppOptions
        {
            Credential = GoogleCredential.FromFile(firebaseCredentials)
        });

        services
            .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddScheme<FirebaseAuthenticationSchemeOptions, FirebaseAuthenticationHandler>(
                JwtBearerDefaults.AuthenticationScheme, null);
    }
}