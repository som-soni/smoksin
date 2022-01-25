#!/usr/bin/sh

# Creating range and enable sharding for ranged_tutorial.users collection
docker exec router mongo --port 27011 --eval '
sh.addShardToZone("rs1", "US"); 
sh.addShardToZone("rs2", "EU");'

docker exec router mongo --port 27011 --eval '
sh.enableSharding("ranged_tutorial"); 
sh.shardCollection("ranged_tutorial.users", {"location" : 1, "_id":1});
sh.addTagRange("ranged_tutorial.users", { "location" : "US", "_id" : MinKey}, { "location" : "US", "_id" : MaxKey}, "US" )
sh.addTagRange("ranged_tutorial.users", { "location" : "EU", "_id" : MinKey}, { "location" : "EU", "_id" : MaxKey}, "EU" )'

# Create Users record for ranged_tutorial
docker exec router mongo ranged_tutorial --port 27011 --eval '
for (var i = 0; i < 500; i++) {
        var firstName = Math.random().toString(36).substr(2, 5);
        var lastName = Math.random().toString(36).substr(2, 5);
        var location = (Math.floor(Math.random() * 2) == 0) ? "US" : "EU";
        var deptCode = Math.floor(Math.random() * 100);
        
        db.users.insert({
                "firstName": firstName,
                "lastName": lastName,
                "deptCode": deptCode,
                "location": location
        });
}
'
