## demo app - developing with Docker

This demo app shows a simple user profile app set up using 
- index.html with pure js and css styles
- nodejs backend with express module
- mongodb for data storage

All components are docker-based

### With Docker

### With Dockerfile (Contenerized App)
Step 0: download the app from github repo
https://github.com/DevWL/mongodb-express-js-app-basic-setup

#### To start the application

Step 0: Create docker network

    docker network create mongo-network 

Step 1: Get the app from the GitHub repo.

Step 2: cd to the project dir (where the Dockerfile is placed).

Step 3: copy & run:
    ````docker rm -f mongodb && docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=root --net mongo-network --name mongodb mongo
    docker rm -f mongo-express && docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ENABLE_ADMIN=true -e ME_CONFIG_MONGODB_ADMINUSERNAME=root -e ME_CONFIG_MONGODB_ADMINPASSWORD=root -e ME_CONFIG_MONGODB_SERVER=mongodb --net mongo-network --name mongo-express mongo-express
    docker rm -f nxapp && docker build -t nxapp . && docker run -p 3000:3000 -di --name nxapp --net mongo-network nxapp
    The last line above basically: removes old container (if exists) -> builds image (nxapp) -> run new app container (nxapp)````

_NOTE: creating docker-network in optional. You can start both containers in a default network. In this case, just emit `--net` flag in `docker run` command_

Step 4: open mongo-express from browser
    On Windows: 

    http://localhost:8081

Step 5: create `user-account` _db_ and `users` _collection_ in mongo-express

Step 6: Start your nodejs application locally - go to `app` directory of project 

    npm install 
    node server.js
    
Step 7: Access you nodejs application UI from browser

    http://localhost:3000

### With Docker Compose

#### To start the application

Step 1: start mongodb and mongo-express

    docker compose -f up
    
_You can access the mongo-express under localhost:8080 from your browser_
    
Step 2: in mongo-express UI - create a new database "my-db"

Step 3: in mongo-express UI - create a new collection "users" in the database "my-db"       
    
Step 4: access the nodejs application from browser 

    http://localhost:3000

### To build a docker image from the application

### push the docker image to your docker repo
    
The dot "." at the end of the command denotes location of the Dockerfile.

#### run the app from the image 
Run app from the docker hub image instead of pulling it from git repo

#### change the code
    ... do something to your app

#### rebuild the image
    cd <project directory> (where Dockerfile is placed)
    docker build -t nxapp:1.0.0 . 

#### Push image to back to repo
    docker push <local-image> <user-name>:<remote-image-name>
    docker push nxapp:1.0.0 devwl:nxapp:1.0.0

## Volumens
    Presist database file in image.
### Export datasbase file 
    This aproach will allow to migrate between different database engine versions. 
### Keep database files in app image 
    Mount volume under docker/mongodb/data for that specyfic database engine version.
    NOTE that you need to define specyfic mongodb version to not run in to the file conflict when building containers.

## Src
    Watch: https://youtu.be/3c-iBn73dDE?t=5288