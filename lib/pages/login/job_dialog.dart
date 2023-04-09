import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/JobSubType.dart';
import '../../models/JobType.dart';
import '../../services/JobService.dart';

class JobTypePage extends StatelessWidget {
  final VoidCallback? onClose;

  const JobTypePage( {super.key, this.onClose});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.2,
          size.width * 0.1, size.height * 0.2),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: BackButton(color: Color(0xff5f66f2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          title: Text(
            '전문 분야',
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
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
                  Navigator.pushReplacement(
                    context,
                    DialogRoute(
                        builder: (context) => JobSubTypePage(jobType, onClose),
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
  final JobType jobType;
  final VoidCallback? onClose;

  JobSubTypePage(this.jobType, this.onClose);

  @override
  Widget build(BuildContext context) {
    Logger logger = Logger();
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.2,
          size.width * 0.1, size.height * 0.2),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: BackButton(color: Color(0xff5f66f2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          title: Text(
            '${jobType.name}',
            style: TextStyle(
              color: Color(0xff5f66f2),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
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
                  Navigator.pushReplacement(
                    context,
                    DialogRoute(
                        builder: (context) =>
                            CareerHistoryPage(jobType, subType, onClose),
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
  final VoidCallback? onClose;

  CareerHistoryPage(this.jobType, this.subType, this.onClose);

  @override
  _CareerHistoryPageState createState() => _CareerHistoryPageState();
}

class _CareerHistoryPageState extends State<CareerHistoryPage> {
  final _formKey = GlobalKey<FormState>();
  String? _errorText;
  String _year = '0';
  String _month = '0';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final jobProvider = Provider.of<JobProvider>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.3,
          size.width * 0.1, size.height * 0.3),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          leading: BackButton(color: Color(0xff5f66f2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          title: Text('해당 분야 경력',
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  children: [
                    Text(
                      '${widget.jobType!.name} > ${widget.subType!.name}',
                      style: TextStyle(
                        color: Color(0xff5f66f2),
                        fontSize: 17,
                        fontFamily: 'S-CoreDream-6',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                      ),
                      child: Flex(
                        mainAxisSize: MainAxisSize.max,
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  hintText: '00',
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    int.parse(value) < 0 ||
                                    int.parse(value) > 20) {
                                  setState(() {
                                    _errorText = "올바른 숫자를 입력하세요!";
                                  },);
                                }else{
                                  setState(() {
                                    _errorText = null;
                                  },);
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _year = value;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '년',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontFamily: 'S-CoreDream-5',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  hintText: '0',
                                  border: InputBorder.none),
                              validator: (value) {
                                if(_year != '0' && value!.isEmpty){
                                  return null;
                                }
                                if (value == null ||
                                    value.isEmpty ||
                                    int.parse(value) < 1 ||
                                    int.parse(value) > 11) {
                                  setState(() {
                                    _errorText = "올바른 숫자를 입력하세요!";
                                  },);
                                }else{
                                  setState(() {
                                    _errorText = null;
                                  },);
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _month = value!;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '개월',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontFamily: 'S-CoreDream-5',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      (_errorText != null) ? '${_errorText}' : '',
                      style: TextStyle(
                        color: Color(0xffff1111),
                        fontFamily: 'S-CoreDream-5',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _errorText==null) {

                          jobProvider.removeElement(widget.subType);
                          jobProvider.addJobCareer(
                              widget.jobType, widget.subType, _year, _month);
                          Navigator.pop(context, true);
                          widget.onClose!();
                        }
                      },
                      child: Text('저장'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
