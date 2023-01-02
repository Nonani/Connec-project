// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          EntryItem(data[index], 0),
      itemCount: data.length,
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;

}

List<Entry> jsonToEntry(dynamic json){
  List<Entry> data = List<Entry>.empty();
  return data;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    '레슨',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    '홈/리빙',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    '이벤트',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
  Entry(
    '비즈니스',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.num);
  final double num;
  final Entry entry;

  Widget _buildTiles1(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          // 이 부분을 go_router 패키지 써서
          // context.go('/${root.title}'), 이런 식으로 할 예정
          print(root.title);
          print(1);
        },
      );
    return Container(
      decoration: UnderlineTabIndicator(
        borderSide: BorderSide(width: 1, color: Color(0xff5f66f2))
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(left: 10),
        key: PageStorageKey<Entry>(root),
        title: Text(root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontSize: 16,
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        children: root.children.map(_buildTiles2).toList(),
      ),
    );
  }
  Widget _buildTiles2(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          // 이 부분을 go_router 패키지 써서
          // context.go('/${root.title}'), 이런 식으로 할 예정
          print(root.title);
          print(2);
        },
      );
    return Container(
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(left: 10),
        key: PageStorageKey<Entry>(root),
        title: Text(root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        children: root.children.map(_buildTiles1).toList(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildTiles1(entry);
  }
}

