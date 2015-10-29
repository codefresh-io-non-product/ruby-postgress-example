
//this file is responsible for creating a user on the db, for our customer to connect to.
//it does so by creating a tmp "system" user, with which it solves a bug in mongo concerning authentication mechanism.
//then it creates a new "root" user (after the bug is resolved), and the tmp system user is removed.
//the new root user is used to generate a db-owner user on the specified db.


print('username: ' + username);
print('password: ' + password);
print('database: ' + database);

function createAdminUser(mongo) {
  mongo = mongo.getSiblingDB("admin");
  mongo.createUser({
    user: 'tmp',
    pwd: 'tmppassword',
    roles: [ { role: "root", db: "admin" }, { role: "__system", db: "admin" } ]
  });

  mongo.auth('tmp', 'tmppassword');

  //bugfix: http://stackoverflow.com/questions/29006887/mongodb-cr-authentication-failed
  var schema = mongo.system.version.findOne({"_id" : "authSchema"});
  schema.currentVersion = 3;
  mongo.system.version.save(schema);

  mongo.createUser({
    user: username,
    pwd: password,
    roles: [ { role: "root", db: "admin" } ]
  });

  mongo.auth(username, password);

  mongo.dropUser('tmp');

  mongo = mongo.getSiblingDB(database);
  mongo.createUser({
    user: username,
    pwd: password,
    roles: [ { role: "dbOwner", db: database } ]
  });
}

