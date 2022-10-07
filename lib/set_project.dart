import 'dart:convert';
import 'dart:io';

import 'constants.dart';
import 'validates.dart' as validates;
import 'config_manager.dart' as config_manager;
import 'directory_manager.dart' as directory_manager;

run(client)async{
  await getClient(client);
}

Future<void> getClient(String? client)async{
  File file = File(configFile);
  String? clientProject = client;
  if(client==null||client.isEmpty){
    clientProject = null;
  }
  if(await file.exists()){
    var str = await file.readAsString();
    final jsonEncoded = json.decode(str);
    bool validateFolders = await validates.validateBeforeRenameFolder(clientProject??clientDefault);
    if(validateFolders){
      stdout.write("Deseja definir ${clientProject} como projeto atual (y/n): ");
      String confirm = stdin.readLineSync()??"n";
      if(confirm == "y"){
        if(confirm=="y"){
          stderr.write("Você optou por SIM definir o projeto como padrão");
          bool success = await directory_manager.run(jsonEncoded['selected_client'], clientProject??clientDefault);
          if(success){
            await createConfig(jsonEncoded['selected_client'], clientProject??clientDefault);
          }
        }
      }else if (confirm=="n"){
        stderr.write("Você optou por NÃO definir o projeto como padrão");
      }else{
        stderr.write("OPÇÃO INVÁLIDA!");
      }
    }else{
      print("CLIENTE INEXISTENTE OU JÁ SELECIONADO");
    }
  }else{
    await createConfig(clientDefault, clientDefault);
  }
}

Future<void> createConfig(String selectedClient, String newClient)async{
  bool validateFolders = await validates.validateAfterRenameFolder(newClient);
  if(validateFolders){
    print("\n • [✓] TODAS AS PASTAS VÁLIDAS PARA O PROJETO \"${newClient.toUpperCase()}\"");
    config_manager.run(selectedClient, newClient);
  }
}