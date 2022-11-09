﻿using FirebaseAdmin;
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

        // Possible that the authentication scheme we want to use is not strictly the JwtBearerDefaults one,
        // though it might also work fine. We can change it if it causes issues down the line. For now, it is simpler
        // to use that notably to use along with Swagger (and overall seems valid to me, despite uncertainty?).
        services
            .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddScheme<FirebaseAuthenticationSchemeOptions, FirebaseAuthenticationHandler>(
                JwtBearerDefaults.AuthenticationScheme, null);
    }
}