import 'package:repo/repo.dart';
import 'package:args/command_runner.dart';
import 'dart:io';

main(List<String> args) {
  var homePath = Platform.environment['HOME'];
  var runner = new CommandRunner("repo", "Manage your github repos.");
  runner.argParser.addOption("config",
      abbr: 'c',
      help: 'Directory of configuration assets.',
      defaultsTo: '$homePath/.repo');

  var results = runner.parse(args);
  var configPath = results['config'];

  runner
    ..addCommand(new ListCommand(configPath))
    ..addCommand(new InitCommand(configPath))
    ..addCommand(new GetCommand(configPath))
    ..addCommand(new CreateCommand(configPath))
    ..run(args);
}
