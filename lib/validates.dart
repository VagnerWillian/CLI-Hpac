import 'dart:io';

Future<bool> validateAfterRenameFolder(client)async{
  bool validate = false;
  validate = await validateFolderEmpty('android', client)&&
  await validateFolderEmpty('ios', client) &&
  await validateFolderEmpty('assets', client);
  return validate;
}

Future<bool> validateBeforeRenameFolder(client)async{
  bool validate = false;
  validate = await validateFolderNotEmpty('android', client)&&
  await validateFolderNotEmpty('ios', client) &&
  await validateFolderNotEmpty('assets', client);
  return validate;
}

Future<bool> validateFolderEmpty(String platform, String client)async{
  bool valid = false;
  Directory directory = Directory('');
  List<FileSystemEntity> files = directory.listSync();
  valid = files.where((i) => i.path.contains("$platform-$client")).toList().isEmpty;
  if(valid){
    print("• [✓] ${platform.toUpperCase()} VÁLIDO");
  }else{
    print("• [X] ${platform.toUpperCase()} INVÁLIDO");
  }
  return valid;
}

Future<bool> validateFolderNotEmpty(String platform, String client)async{
  bool valid = false;
  Directory directory = Directory('');
  List<FileSystemEntity> files = directory.listSync();
  valid = files.where((i) => i.path.contains("$platform-$client")).toList().isNotEmpty;
  if(valid){
    print("• [✓] ${platform.toUpperCase()} VÁLIDO");
  }else{
    print("• [X] ${platform.toUpperCase()} INVÁLIDO");
  }
  return valid;
}