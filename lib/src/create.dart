import 'package:args/args.dart' as args;
import 'package:args/command_runner.dart';
import 'dart:async';
import 'base.dart';
import 'dart:io';
import 'package:github/server.dart' as github;

class CreateCommand extends BaseCommand {
  final name = "create";
  final description = "Create github repo.";

  CreateCommand(String configPath) : super(configPath) {
    argParser.addFlag("private", abbr: "p", defaultsTo: true);
  }

  Future run() async {
    var rest = argResults.rest;
    if (rest.isEmpty)
      print(usage);
    else {
      var repoList = await client.repositories.listRepositories().toList();
      repoList = repoList.map((r) => r.name);
      var name = rest.first;
      if (repoList.contains(name)) {
        print("$name already exists.");
        exit(1);
      } else {
        var owner = await client.users.getCurrentUser();
        var repo = new github.CreateRepository(name);
        repo.private = argResults['private'];
        await client.repositories.createRepository(repo);
        var slug = new github.RepositorySlug(owner.login, name);
        var r = await client.repositories.getRepository(slug);
        print(r.cloneUrls.ssh);
      }
    }
    exit(0);
    // client.repositories.listRepositories().listen((r) {
    // 	print(r.name);
    // }).onDone(() => exit(0));
    // print(argResults);
  }
}
