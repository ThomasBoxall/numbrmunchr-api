import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:io';
import 'package:yaml/yaml.dart';

import 'package:numbrmunchr_api/APIHandler.dart';  
import 'package:numbrmunchr_api/database.dart';

Future<int>? main() async {
  final app = Router();
  late dynamic configMap;

  // first thing we do is check if the config file exists. if it does then we vibe, if it doesn't then we cry.
  if (await File('config.yaml').exists()) {
    final config = File('config.yaml').readAsStringSync();
    configMap = loadYaml(config);
    print(configMap.toString());
  } else {
    print("no config file found");
    return -1;
  }

  // now we initialise the database, using the config file
  Database db = Database();
  await db.init(configMap);
  // now initialise the APIHandler which will handle the requests to the API
  APIHandler apiHandler = APIHandler(db);

  // requests
  app.get("/database-test", apiHandler.databaseTest);

  // Now we ✨serve✨ (TODO move server and port to the config file)
  await shelf_io.serve(app, 'localhost', 5420);

  print('Serving');

  return 0;
}
