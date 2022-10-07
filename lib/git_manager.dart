
import 'dart:io';
import 'package:git/git.dart' as git;

Future addAll()async{
  await git.runGit(['add', '*']);
}