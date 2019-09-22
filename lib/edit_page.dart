import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String text;
  EditPage(this.text);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = widget.text;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      appBar: AppBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        elevation: 0.0,
        title: Text(
          'Edit your Note',
          style: Theme.of(context).textTheme.display1.copyWith(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.9),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () {
              if (controller.text.isEmpty) {
                Navigator.of(context).pop({'type': 2});
              } else {
                Navigator.of(context).pop({'type': 1, 'text': controller.text});
              }
            }),
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.all(0.0),
              tooltip: 'Delete note',
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop({'type': 2});
              }),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: TextField(
            scrollPhysics: BouncingScrollPhysics(),
            decoration: InputDecoration(
                hintText: "Edit your note",
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(15.0)),
            keyboardType: TextInputType.multiline,
            maxLines: 99999,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.black87, letterSpacing: 0.6),
            controller: controller,
            autofocus: true,
          ),
        ),
      ),
      resizeToAvoidBottomPadding: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Apply'),
        icon: Icon(Icons.done),
      ),
    );
  }
}
