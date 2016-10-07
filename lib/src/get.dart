import 'package:args/args.dart' as args;
import 'package:args/command_runner.dart';
import 'dart:async';
import 'base.dart';
import 'dart:io';
import 'package:github/server.dart' as github;

class GetCommand extends BaseCommand {
  final name = "get";
  final description = "Get github repo detail.";
  final usage = "repo get <full or partial name>";

  GetCommand(String configPath) : super(configPath);

  Future run() async {
    var rest = argResults.rest;
    if (rest.isEmpty)
      print(usage);
    else {
      var repoList = await client.repositories.listRepositories().toList();
      var q = rest.first;
      var rx = new RegExp(q);
      var repo = repoList.firstWhere((r) => rx.hasMatch(r.name));
      print(repo.cloneUrls.ssh);
    }
    exit(0);
    // client.repositories.listRepositories().listen((r) {
    // 	print(r.name);
    // }).onDone(() => exit(0));
    // print(argResults);
  }
}
