#!/usr/bin/sh

# Enable sharding for hashed_tutorial.users collection
docker exec router mongo --port 27011 --eval 'sh.enableSharding("hashed_tutorial"); sh.shardCollection("hashed_tutorial.users", {"deptCode" : "hashed"});'

# Create Users record for hashed_tutorial
docker exec router mongo hashed_tutorial --port 27011 --eval '
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
