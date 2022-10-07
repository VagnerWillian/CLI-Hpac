
import 'dart:io';

Future addAll()async{
  await Process.start('git', ['add', '*'], runInShell: true);
}