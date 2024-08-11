import 'package:shelf/shelf.dart';

import 'package:numbrmunchr_api/database.dart';

// handles the API requests
class APIHandler {
  Database db;
  // object is instantiated with the database pre setup
  APIHandler(this.db);

  // return contents of the test table. 
  Future<Response> databaseTest(Request request) async {
    final _dbResp= await db.getTestTable();

    return Response.ok(_dbResp);
  }

}

