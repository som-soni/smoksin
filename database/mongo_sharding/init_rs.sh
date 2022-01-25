#!/usr/bin/sh

docker exec config mongo --port 27010 --eval  'rs.initiate({
    _id: "rs0",
    version: 1,
    members: [{
        _id: 0,
        host: "config:27010"
    }]
})'

docker exec shard1 mongo --port 27012 --eval 'rs.initiate({
    _id: "rs1",
    version: 1,
    members: [{
        _id: 0,
        host: "shard1:27012"
    }]
})'

docker exec shard2 mongo --port 27013 --eval 'rs.initiate({
    _id: "rs2",
    version: 1,
    members: [{
        _id: 0,
        host: "shard2:27013"
    }]
})'

docker exec router mongo --port 27011 --eval '
sh.addShard("rs1/shard1:27012"); 
sh.addShard("rs2/shard2:27013");'
