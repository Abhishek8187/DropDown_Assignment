import 'package:flutter/material.dart';

class SizeProvider with ChangeNotifier{

  List<int> _selectedOptionIndex = [-1,-1,-1,-1];
  List<int> get selectedOptionIndex =>_selectedOptionIndex;

  void onOptionSelected(int index, int serialNo) {
      _selectedOptionIndex[index] = serialNo;
      notifyListeners();
  }
}