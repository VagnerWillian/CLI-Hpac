import 'dart:io';

Future<bool> run(String client, String newClient)async{
  bool success = false;
  success = await renameFolderDeactivate('android', client)&&
      await renameFolderDeactivate('ios', client) &&
      await renameFolderDeactivate('assets', client);
  if(!success){
    print("\n • [X] NÃO FOI POSSÍVEL RENOMEAR PASTA DO CLIENTE SELECIONADO \"${client.toUpperCase()}\"");
  }else{
    await Future.delayed(Duration(seconds: 2));
    bool success = false;
    success = await renameFolderActivate('android', newClient)&&
        await renameFolderActivate('ios', newClient) &&
        await renameFolderActivate('assets', newClient);
    if(!success){
      print("\n • [X] NÃO FOI POSSÍVEL RENOMEAR PASTA DO NOVO CLIENTE \"${newClient.toUpperCase()}\"");
    }
  }
  return success;
}

Future<bool> renameFolderDeactivate(String folder, String client)async{
  bool success = false;
  Directory directory = Directory('');
  List<FileSystemEntity> files = directory.listSync();
  for (var i in files){
    if (i.path==".\\$folder"){
      print("DESATIVANDO ${i.path}...");
      success = true;
      await i.rename(".\\$folder-$client");
    }
  }
  return success;
}

Future<bool> renameFolderActivate(String folder, String client)async{
  bool success = false;
  Directory directory = Directory('');
  List<FileSystemEntity> files = directory.listSync();
  for (var i in files) {
    if (i.path==".\\$folder-$client"){
      print("ATIVANDO ${i.path}...");
      success = true;
      await i.rename(".\\$folder-$client".replaceAll("-$client", ''));
    }
  }
  return success;
}