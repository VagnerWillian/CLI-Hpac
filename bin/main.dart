import 'dart:io';

import 'package:args/args.dart';
import 'package:hpac/constants.dart';
import 'package:hpac/set_project.dart' as setProject;
import 'package:hpac/config_manager.dart' as config_manager;
import 'package:hpac/git_manager.dart' as git_manager;

void main(List<String> arguments) async{
  var parser = ArgParser();
  var command = ArgParser();
  parser.addCommand('help', command);
  parser.addCommand('info', command);
  parser.addCommand('clear', command);
  parser.addCommand('add', command);
  parser.addOption('set', abbr: 's');
  var args  = parser.parse(arguments);

  print("•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••");
  print("••••••••••••••••••••••••HPAC CLI••••••••••••••••••••••••••••••••");
  print("••••••••••••DESENVOLVIDO POR HAMMER CONSULT•••••••••••••••••••••");
  print("•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••");
  if(args.command?.name=='add'){
    await setProject.run(clientDefault);
    print("GIT ADD * ...");
    await git_manager.addAll();
  }else if(args.command?.name=='help'){
    print("-s(or --set) \"<client-name>\"");
    print("info • for actually selected client");
    print("help • help for commands");
    print("clear • for clear archive of configuration");
  }else if(args.command?.name=='info'){
    String status = await config_manager.readStatusConfigFile();
    print("•••••••••••• CLIENTE SELECIONADO ${status.toUpperCase()} •••••••••••••••••••••");
  }else if(args.command?.name=='clear'){
    config_manager.clear();
  }else if(args.options.contains("set")){
    setProject.run(args['set']);
  }else {
    print("???????? COMANDO DESCONHECIDO ?????????");

  }
}
