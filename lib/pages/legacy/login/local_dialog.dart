import 'package:connec/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../../services/LocalService.dart';



class LocalData {
  final String code;
  final int tier;
  final String parent;
  final String title;

  LocalData(this.code, this.tier, this.parent, this.title);
}

class LocalDataScreen extends StatelessWidget {
  final VoidCallback? onClose;
  final CollectionReference localDataCollection =
      FirebaseFirestore.instance.collection('localData');

  LocalDataScreen({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final localProvider = Provider.of<LocalProvider>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.2,
          size.width * 0.1, size.height * 0.2),
      child: Scaffold(
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
            '활동지',
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: localDataCollection.where('tier', isEqualTo: 1).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CustomLoadingDialog();
            }
            print(snapshot.data!.size);
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                LocalData localData = LocalData(document['code'],
                    document['tier'], document['parent'], document['title']);
                return ListTile(
                  title: Text(localData.title),
                  onTap: () {
                    if (localData.title == '전국') {
                      localProvider.setLocal("전국");
                      localProvider.setSubLocal("전국");
                      localProvider.setLocalCode("0000000");
                      localProvider.setSubLocalCode("0000000");
                      onClose!();
                      Navigator.pop(context);
                    } else {
                      localProvider.setLocal(document['title']);
                      localProvider.setLocalCode(document['code']);
                      Navigator.pushReplacement(
                        context,
                        DialogRoute(
                          context: context,
                          builder: (context) => SubLocalDataScreen(
                              parentCode: localData.code, onClose: onClose),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class SubLocalDataScreen extends StatelessWidget {
  final VoidCallback? onClose;
  final CollectionReference localDataCollection =
      FirebaseFirestore.instance.collection('localData');
  final String parentCode;

  SubLocalDataScreen({required this.parentCode, this.onClose});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final localProvider = Provider.of<LocalProvider>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.2,
          size.width * 0.1, size.height * 0.2),
      child: Scaffold(
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
            '${localProvider.local.local}',
            style: TextStyle(
              color: Color(0xff5f66f2),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: localDataCollection
              .where('parent', isEqualTo: parentCode)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CustomLoadingDialog();
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                LocalData localData = LocalData(document['code'],
                    document['tier'], document['parent'], document['title']);
                return ListTile(
                  title: Text(localData.title),
                  onTap: () {
                    // 선택한 지역 정보 처리

                    localProvider.setSubLocal(document['title']);
                    localProvider.setSubLocalCode(document['code']);
                    Navigator.pop(context);
                    onClose!();
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
