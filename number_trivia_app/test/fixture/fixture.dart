import 'dart:io';

String fixture(String file) => File("test/fixture/$file").readAsStringSync();
