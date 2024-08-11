import 'package:postgres/postgres.dart';
import 'package:yaml/yaml.dart';

// Database wrangler
class Database{
  // object contains _db var which contains the open connection for the database (should probably think about closing it at some point)
  late Connection _db;

  Future<void> init(YamlMap configOptions) async{
    _db = await Connection.open(
      Endpoint(
        host: configOptions['db']?['host'],
        database: configOptions['db']?['database'],
        username: configOptions['db']?['username'],
        password: configOptions['db']?['password'],
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    print("init complete");
  }

  // we can now use the above mentioned _db var to CRUD at the database, well just R for now.
  Future<String> getTestTable() async{
    final response = await _db.execute("SELECT * FROM testtable");
    return response.toString();
  }


}