import 'package:args/args.dart' as args;
import 'package:args/command_runner.dart';
import 'dart:async';
import 'base.dart';
import 'dart:io';
import 'package:github/server.dart' as github;

class ListCommand extends BaseCommand {
  final name = "list";
  final description = "List github repos.";

  ListCommand(String configPath) : super(configPath);

  Future run() async {
    var repoList = await client.repositories.listRepositories().toList();
    var rest = argResults.rest;
    if (rest.isEmpty)
      repoList.forEach((r) => print(r.name));
    else {
      var q = rest.first;
      var rx = new RegExp(q);
      repoList.where((r) => rx.hasMatch(r.name)).forEach((r) => print(r.name));
    }
    exit(0);
    // client.repositories.listRepositories().listen((r) {
    // 	print(r.name);
    // }).onDone(() => exit(0));
    // print(argResults);
  }
}
