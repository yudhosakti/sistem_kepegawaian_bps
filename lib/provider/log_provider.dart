import 'package:flutter/material.dart';
import 'package:simpeg/models/log_model.dart';

class LogProvider extends ChangeNotifier {
  List<LogModel> logList = [];

  void setLogList(List<LogModel> newModel) {
    logList = newModel;
  }

  
}
