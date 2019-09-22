import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CardItem.dart';
import 'edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<String> _list;

  @override
  void initState() {
    super.initState();
    _list = ListModel<String>(
      listKey: _listKey,
      initialItems: <String>[
        "Welcome to DevFest 2019",
        "Hey This is Cool flutter Note",
        "Click here to edit this",
        "You can run it in any platform"
      ],
      removedItemBuilder: _buildRemovedItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      appBar: AppBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        elevation: 0.0,
        title: Text(
          'Flutter Notes',
          style: Theme.of(context).textTheme.display1.copyWith(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.9),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Add a new note',
        onPressed: () {
          setState(() {
            _list.insert(0, 'Click to edit new note');
          });
        },
        icon: Icon(Icons.add),
        label: Text('Add Note'),
      ),
      body: AnimatedList(
        padding: EdgeInsets.only(top: 30.0),
        physics: BouncingScrollPhysics(),
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      onTap: () async {
        Map res = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditPage(_list[index])));
        if (res['type'] == 1) {
          setState(() {
            _list.edit(index, res['text']);
          });
        } else {
          _list.removeAt(index);
        }
      },
      onLongPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you sure to delete?'),
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.all(0.0),
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  padding: EdgeInsets.all(0.0),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _list.removeAt(index);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRemovedItem(
      String item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
    );
  }
}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  void edit(int index, E item) {
    _items[index] = item;
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
