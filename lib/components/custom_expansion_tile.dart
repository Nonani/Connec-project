import 'package:flutter/material.dart';
import 'dart:convert';

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
List<Entry> parseEntries(String jsonString) {
  final List<dynamic> parsed = jsonDecode(jsonString);
  List<Entry> entries = [];
  for (var entry in parsed) {
    entries.add(Entry.fromJson(entry));
  }
  return entries;
}

class Entry {
  final String title;
  final List<Entry> children;

  Entry({required this.title, required this.children});

  factory Entry.fromJson(Map<String, dynamic> json) {
    var childrenJson = json['children'] as List<dynamic>;
    List<Entry> children = childrenJson.map((i) => Entry.fromJson(i)).toList();
    return Entry(
      title: json['title'],
      children: children,
    );
  }
}

String json = """
[
  {
    "title": "String1",
    "children": [
      { "title": "1", "children": [
      {"title" : "1", "children" : []
      }
      ] },
      { "title": "2", "children": [] }
    ]
  },
  {
    "title": "String2",
    "children": [
      { "title": "3", "children": [] },
      { "title": "4", "children": [] }
    ]
  }]
""";

// The entire multilevel list displayed by this app.
final List<Entry> data = parseEntries(json);

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.num);

  final double num;
  final Entry entry;

  Widget _buildTiles1(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(
          root.title,
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
        },
      );
    return Container(
      decoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1, color: Color(0xff5f66f2))),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(left: 10),
        key: PageStorageKey<Entry>(root),
        title: Text(
          root.title,
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
        title: Text(
          root.title,
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
        },
      );
    return Container(
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(left: 10),
        key: PageStorageKey<Entry>(root),
        title: Text(
          root.title,
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
