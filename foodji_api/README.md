# FooDJi Back End

## Database

The database used for this project is [MongoDB](https://www.mongodb.com/). As such, we are working in a NoSQL environment.

To get started, you will need to:
- [Install Docker](https://www.docker.com/)
- Because we are using secret files in the `docker-compose.yml` (as described [in the MongoDB image documentation](https://hub.docker.com/_/mongo) and elsewhere online), you will need to create a couple of files in a `secrets` folder, which are otherwise part of the `.gitignore`. The content of these is mostly irrelevant for local development, aside from the fact it needs to match the connection string used in the code, and requires no whitespace or newline. These are:
  - `foodji_api/secrets/root_username.txt`, containing a root username for the database
  - `foodji_api/secrets/root_password.txt`, containing a root password for the database
- Speaking of connection strings, you should take the moment at this point to match it to the username and password you used above, or directly use the ones that are currently in the code to fill these documents. For the moment, since this is only local development, these can be found directly in the `appsettings.json` file , but should be moved to a secrets file in the future.
- Once that is done, you can run `docker-compose up` from this directory. Your database should be up and running, so that the connection may be established for the program to initialize and update it when required.