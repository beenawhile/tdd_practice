import 'package:flutter/material.dart';

abstract class MusicLibraryItem {
  int getItemsCount();
  int getDuration();
  Widget build(BuildContext context);
}
