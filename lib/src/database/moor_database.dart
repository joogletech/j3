import 'dart:io';
import 'dart:math';

import 'package:j3enterprise/src/models/background_job_schedule_model.dart';
import 'package:j3enterprise/src/models/background_jobs_logs_model.dart';
import 'package:j3enterprise/src/models/user_model.dart';
import 'package:j3enterprise/src/models/communication_model.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart' as paths;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// import 'dart:io' show Platform;
// import 'dart:io' as io;

part 'moor_database.g.dart';

class AppDatabase extends _$AppDatabase {
  static AppDatabase _db = _constructDb();

  factory AppDatabase() {
    return _db;
  }

  AppDatabase._internal(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;

  static AppDatabase _constructDb({bool logStatements = false}) {
    if (Platform.isIOS || Platform.isAndroid) {
      final executor = LazyDatabase(() async {
        final dataDir = await paths.getApplicationDocumentsDirectory();
        final dbFile = File(p.join(dataDir.path, 'db.sqlite'));
        return VmDatabase(dbFile, logStatements: logStatements);
      });
      return AppDatabase._internal(executor);
    }
    if (Platform.isMacOS || Platform.isLinux) {
      final file = File('db.sqlite');
      return AppDatabase._internal(
          VmDatabase(file, logStatements: logStatements));
    }
    if (Platform.isWindows) {
      final file = File('db.sqlite');
      return AppDatabase._internal(
          VmDatabase(file, logStatements: logStatements));
    }
    return AppDatabase._internal(
        VmDatabase.memory(logStatements: logStatements));
  }
}
