
import 'dart:io';

Future addAll()async{
  await Process.start('TASKKILL "/IM", "hpac.exe", "/f"', [], runInShell: true, mode: ProcessStartMode.detachedWithStdio);
  await Process.start('git', ["add", "*"], runInShell: true, mode: ProcessStartMode.detachedWithStdio);
}