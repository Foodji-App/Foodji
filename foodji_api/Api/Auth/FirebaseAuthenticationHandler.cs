using System.Security.Claims;
using System.Security.Principal;
using System.Text.Encodings.Web;
using FirebaseAdmin.Auth;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;

namespace Api.Auth;

// See https://dotnetcorecentral.com/blog/authentication-handler-in-asp-net-core/
// Also https://referbruv.com/blog/implementing-custom-authentication-scheme-and-handler-in-aspnet-core-3x/
public class FirebaseAuthenticationHandler : AuthenticationHandler<FirebaseAuthenticationSchemeOptions>
{
    public FirebaseAuthenticationHandler(
        IOptionsMonitor<FirebaseAuthenticationSchemeOptions> options,
        ILoggerFactory logger,
        UrlEncoder encoder,
        ISystemClock clock) 
            : base(options, logger, encoder, clock)
    {
    }

    protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
    {
        string authorizationHeader = Request.Headers["Authorization"];
        if (string.IsNullOrEmpty(authorizationHeader))
        {
            return AuthenticateResult.NoResult();
        }
        var token = authorizationHeader.Substring("bearer".Length).Trim();
 
        if (string.IsNullOrEmpty(token))
        {
            return AuthenticateResult.Fail("Unauthorized");
        }
        
        try
        {
            var validatedToken = await FirebaseAuth.DefaultInstance.VerifyIdTokenAsync(token);
            
            // This section could be customized further depending on our needs,
            // including managing roles in the principal, for instance
            var claims = validatedToken.Claims.Select(x => new Claim(x.Key, x.Value.ToString() ?? string.Empty));
            var identity = new ClaimsIdentity(claims, Scheme.Name);
            var principal = new GenericPrincipal(identity, null);
            
            var authenticationTicket = new AuthenticationTicket(principal, Scheme.Name);
            
            return AuthenticateResult.Success(authenticationTicket);
        }
        catch (ArgumentException e)
        {
            Console.WriteLine(e);
            return AuthenticateResult.Fail("Empty token");
        }
        catch (FirebaseAuthException e)
        {
            Console.WriteLine(e);
            return AuthenticateResult.Fail("Invalid token");
        }
    }
}