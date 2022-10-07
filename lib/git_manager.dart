
import 'dart:io';

Future addAll()async{
  final process = await Process.start('git', ['add', '*'], runInShell: true);
}