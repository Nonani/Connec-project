import 'package:connec/models/JobSubType.dart';
import 'package:connec/models/JobType.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Job {
  JobType? type;
  JobSubType? subType;
  Career? career;

  Job({
    this.type,
    this.subType,
    this.career,
  });
}
class Career {
  final String year;
  final String month;

  Career({
    required this.year,
    required this.month,
  });
}
class JobProvider with ChangeNotifier {
  List<Job> _jobList = [];


  // void addJob(JobType jobType){
  //   _jobList.add(Job(type: jobType, subType: null,career: null ));
  // }
  // void addSubJob(JobType? jobType, JobSubType? careerType) {
  //   final index = _jobList.indexWhere((job) => job.type == jobType && job.subType == careerType);
  //   if (index != -1) {
  //     _jobList[index].subType = careerType;
  //     notifyListeners();
  //   }
  // }
  void addJobCareer(
      JobType jobType, JobSubType subType, String year, String month) {
      Logger logger = Logger();

      final career = Career(
        year: year,
        month: month
      );
      _jobList.add(Job( type: jobType,subType: subType, career: career));
      notifyListeners();
      _jobList.forEach((element) {
        logger.w(element.type!.name);
      });
  }

  List<Job> get jobList => _jobList;
}