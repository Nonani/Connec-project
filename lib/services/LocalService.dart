import 'package:connec/models/JobSubType.dart';
import 'package:connec/models/JobType.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Local {
  String? local;
  String? sub_local;
  String? local_code;
  String? sub_local_code;

  Local({
    this.local,
    this.sub_local,
    this.local_code,
    this.sub_local_code
  });
}
class LocalProvider with ChangeNotifier {
  Local local = Local(local: null, sub_local: null);
  void setLocal(String str){
    local.local = str;
  }
  void setSubLocal(String str){
    local.sub_local = str;
  }
  void setLocalCode(String str){
    local.local_code = str;
  }
  void setSubLocalCode(String str){
    local.sub_local_code = str;
  }
}