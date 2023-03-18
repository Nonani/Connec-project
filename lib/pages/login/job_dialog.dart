import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/JobSubType.dart';
import '../../models/JobType.dart';
import '../../services/Job.dart';

class JobTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          title: Text('Job Type'),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: ListView.builder(
            itemCount: jobTypes.length,
            itemBuilder: (context, index) {
              final jobType = jobTypes[index];
              return ListTile(
                title: Text(jobType.name),
                onTap: () {
                  ;
                  Navigator.push(
                    context,
                    DialogRoute(
                        builder: (context) => JobSubTypePage(jobType),
                        context: context),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class JobSubTypePage extends StatelessWidget {
  final jobType;

  JobSubTypePage(this.jobType);

  @override
  Widget build(BuildContext context) {
    // final jobProvider = Provider.of<JobProvider>(context);
    // final selectedJob = jobType;
    Logger logger = Logger();
    // logger.w(selectedJob.type == jobTypes[0]);
    // logger.w(subTypes[jobTypes[0].code]);
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          title: Text('Career Type'),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: ListView.builder(
            itemCount: subTypes[jobType.code]!.length,
            itemBuilder: (context, index) {
              final subType = subTypes[jobType.code]![index];
              return ListTile(
                title: Text(subType.name),
                onTap: () {
                  // jobProvider.addSubJob(selectedJob.type, subType);
                  Navigator.push(
                    context,
                    DialogRoute(
                        builder: (context) =>
                            CareerHistoryPage(jobType, subType),
                        context: context),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CareerHistoryPage extends StatefulWidget {
  final jobType;
  final subType;

  CareerHistoryPage(this.jobType, this.subType);

  @override
  _CareerHistoryPageState createState() => _CareerHistoryPageState();
}

class _CareerHistoryPageState extends State<CareerHistoryPage> {
  final _formKey = GlobalKey<FormState>();
  late String _year;
  late String _month;

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    // final selectedJob = jobProvider.jobList.last;
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          title: Text('Career History'),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(hintText: 'Start Date'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 0 ||
                        int.parse(value) > 50) {
                      return 'Please enter a year.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _year = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(hintText: 'End Date'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) <= 0 ||
                        int.parse(value) > 12) {
                      return 'Please enter an end date.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _month = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      jobProvider.addJobCareer(widget.jobType, widget.subType, _year, _month);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
