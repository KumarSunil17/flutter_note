import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      this.onLongPressed,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final VoidCallback onLongPressed;
  final String item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        Theme.of(context).textTheme.display1.copyWith(color: Colors.black);
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: InkWell(
//        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        onLongPress: onLongPressed,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
          child: Material(
            elevation: 8.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            shadowColor: Theme.of(context).primaryColor.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Text(item, style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
