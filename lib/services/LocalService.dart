import 'package:connec/models/JobSubType.dart';
import 'package:connec/models/JobType.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Local {
  String? local;
  String? subLocal;
  String? localCode;
  String? subLocalCode;

  Local({
    this.local,
    this.subLocal,
    this.localCode,
    this.subLocalCode
  });
}
class LocalProvider with ChangeNotifier {
  Local local = Local(local: null, subLocal: null);
  void setLocal(String str){
    local.local = str;
  }
  void setSubLocal(String str){
    local.subLocal = str;
  }
  void setLocalCode(String str){
    local.localCode = str;
  }
  void setSubLocalCode(String str){
    local.subLocalCode = str;
  }
}