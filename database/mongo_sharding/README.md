
# Mongo Sharding Tutorial

This repository has the docker-compose file that creates a mongo cluster using docker containers. It has also the scripts that sets up sharded DB and sets up the data for sharded collections.


## Usage

* **docker-compose up -d**   will start a mongo cluster with 2 db shards
* **sh init_rs.sh** initializes the replicaset for all the mongo servers including config, router and shards. It also adds the shards to router server
* **sh setup_hashed.sh** sets up the data for hashed sharded collection (*users*) in (*hashed_tutorial*) db.
* **sh setup_ranged.sh** sets up the data for ranged sharded collection (*users*) in (*ranged_tutorial*) db.
