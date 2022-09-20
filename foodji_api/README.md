# FooDJi Back End

## Database

The database used for this project is [MongoDB](https://www.mongodb.com/). As such, we are working in a NoSQL environment.

To get started, you will need to:
- [Install Docker](https://www.docker.com/)
- Because we are using secret files in the `docker-compose.yml` (as described [in the MongoDB image documentation](https://hub.docker.com/_/mongo) and elsewhere online), you will need to create a couple of files in a `secrets` folder, which are otherwise part of the `.gitignore`. The content of these is mostly irrelevant for local development, aside from the fact it needs to match the connection string used in the code, and require no whitespace or newline. These are:
  - `foodji_api/secrets/root_username.txt`, containing a root username for the database
  - `foodji_api/secrets/root_password.txt`, containing a root password for the database
- Speaking of connection strings, you should take the moment at this point to match it to the username and password you used above, or directly use the one currently in the code to fill these documents. For the moment, since this is only local development, this can be found directly in the `Program.cs` file when creating the client, but should be moved to a secrets file similar to the `appsettings.json` in the future.
- Once that is done, you can run `docker-compose up` from this directory, and your database should be running, and the code will be able to connect to it to initialize and update it when you run it.