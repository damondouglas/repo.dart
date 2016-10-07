library repo.base;

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:github/server.dart' as github;
import 'dart:io';
import 'dart:async';

abstract class BaseCommand extends Command {
  String configPath;
  String get tokenPath => path.join(configPath, '.token');
  String get token => () {
        var f = new File(tokenPath);
        var data = f.readAsStringSync();
        return data.trim();
      }();
  github.Authentication get authentication =>
      new github.Authentication.withToken(token);
  github.GitHub get client => new github.GitHub(auth: authentication);
  BaseCommand(this.configPath);
  bool checkConfig() {
    var checks = [tokenPath].every((p) {
      var f = new File(p);
      var exists = f.existsSync();
      var length = f.lengthSync();
      if (!exists) print("$p does not exist.");
      if (exists && length == 0) print("$p is empty.");
      return exists && length > 0;
    });

    if (!checks) exit(1);

    return checks;
  }
}
