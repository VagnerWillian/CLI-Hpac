
import 'dart:io';
import 'package:git/git.dart' as git;

Future addAll()async{
  // await Process.start('git', ["add", "*"], runInShell: true, mode: ProcessStartMode.detached);
  await git.runGit(['add', '*']);
}