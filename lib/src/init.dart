import 'package:args/args.dart' as args;
import 'package:args/command_runner.dart';
import 'dart:async';
import 'base.dart';
import 'dart:io';

class InitCommand extends BaseCommand {
  final name = "init";
  final description = "Initiate application.";

  InitCommand(String configPath) : super(configPath);

  Future run() => new Future(() async {
        print("Initiating config...");
        var completer = new Completer();
        var dir = new Directory(configPath);
        if (!dir.existsSync()) await dir.create(recursive: true);
        var f = new File(tokenPath);
        if (!f.existsSync()) await f.create();
        completer.complete();
        return completer.future;
      });
}
