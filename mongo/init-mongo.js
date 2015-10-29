load('/opt/codefresh/mongo/mongo-wait.js');
load('/opt/codefresh/mongo/create-admin-user.js');

var conn = waitForMongo();
var db = conn.getDB('admin');
createAdminUser(db);
