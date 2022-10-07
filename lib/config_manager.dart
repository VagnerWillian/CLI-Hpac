import 'dart:convert';
import 'dart:io';

void run(String selectedClient, String newClient){
  print("CRIANDO ARQUIVO DE CONFIGURAÇÃO PARA ${newClient.toUpperCase()}");
  createConfigFile(newClient);
}

Future<void> createConfigFile(client)async{
  File file = await File("hpac_config.json").create();
  var encoder = JsonEncoder.withIndent("  ");
  Map<String, dynamic> data = {
    "selected_client" : client
  };
  file.writeAsString(encoder.convert(data));
}

Future<void> clear()async{
  File file = File("hpac_config.json");
  print("ARQUIVO DE CONFIGURAÇÃO DELETADO COM SUCESSO!");
  await file.delete();
}

Future<String> readStatusConfigFile()async{
  String str = await File("hpac_config.json").readAsString();
  var jsonDecoded = json.decode(str);
  return jsonDecoded['selected_client'];
}