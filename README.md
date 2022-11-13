# Foodji

Une application multiplateforme simple pour vos recettes!

## Description

Grâce à Foodji, il devient facile de pouvoir créer et personnaliser vos recette!
Fini les petites notes sur le coin d'une feuille. Vous pourrez annoter et substiuer comme bon vous semble les divers ingrédients à chacune de vos recette!

## Installer et exécuter le projet

### Serveur API (Back-end)
> Installer au préalable [Visual Studio 2022](https://visualstudio.microsoft.com/fr/vs/) avec dotnet 6, ainsi que [docker desktop](https://www.docker.com/) pour exécuter l'environnement de développement.

1. Ouvrir [FoodjiApi.sln](./foodji_api/FoodjiApi.sln) avec Visual Studio 2022.

2. Créer un dossier appelé *secrets* à la racine du dossier [foodji_api](./foodji_api/). Créer dans celui-ci les fichiers *root_password.txt* et *root_username.txt*, avec les informations d'authentification nécessaires.

3. Ouvrir une console dans [foodji_api](./foodji_api/) et exécuter *`docker-compose up`* afin de démarrer la base de donnée Mongo.

### Application (Front-end)
> Consulter la documentation [Flutter](https://docs.flutter.dev) afin pour installer l'environnement de développement.

*NB : La version actuellement développé fut optimisée pour la plateforme android*

1. Ouvrir une console dans [foodji_ui](./foodji_ui/) et exécuter *flutter run*. Vous pourrez ensuite choisir la plateforme cible et le tour est joué!


## Auteurs

Membres du projet à l'automne 2022

* Éloyze Brière-Alix
* Mikaël Hubert-Deschamps
* Francis Sarrazin
* Guillaume Gervais

## Historique des versions
* 0.3 [WIP]
* 0.2
    * Authentification
    * Formulaire de création de recette
    * Filtres avancés de recherche de recette
    * Connexion bout en bout de la solution
* 0.1
    * Instanciation des écrans android
        * Écran de démarrage
        * Liste des recettes
        * Details d'une recette
    * Initialisation de l'api DotNet et de sa base de données MongoDB
* 0.0
    * Analyse et formation
    * Démarrage du git

## Licence
Ce projet est sous licence MIT - voir le fichier LICENSE.md pour plus de détails

## Références

Inspiration, code snippets, etc.
* [MongoDB](https://www.mongodb.com/)
* [Docker](https://www.docker.com/)
* [Firebase](https://firebase.google.com/)
* [Flutter](https://docs.flutter.dev)
* [FlutterTemplates](https://www.fluttertemplates.dev/)
* [Tutoriel Flutter recommandé](https://youtu.be/x4DydJKVvQk)
* [Icônes Material](https://fonts.google.com/icons?selected=Material+Icons)
* [Internationalisation](https://phrase.com/blog/posts/flutter-localization/)
