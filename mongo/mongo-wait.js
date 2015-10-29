
function waitForMongo() {
    var conn;
    print('waiting for mongo to start listening on localhost:27017');
    try
    {
        conn = new Mongo("localhost:27017");
    }
    catch(Error)
    {
        print('.');
    }
    while(conn === undefined)
    {
        try
        {
            conn = new Mongo("localhost:27017");
        }
        catch(Error)
        {
            print('.');
        }
        sleep(1000);
    }
    return conn;
}
