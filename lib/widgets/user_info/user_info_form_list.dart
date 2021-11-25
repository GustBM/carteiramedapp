import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UserInfoFormList extends StatefulWidget {
  final String labelText;
  final List<String> list;
  final bool readOnly;
  UserInfoFormList(this.labelText, this.list, this.readOnly);

  @override
  _UserInfoFormListState createState() => _UserInfoFormListState();
}

class _UserInfoFormListState extends State<UserInfoFormList> {
  TextEditingController myController = TextEditingController();

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
	var t = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.readOnly
              ? Text(widget.labelText)
              : Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          labelText: widget.labelText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(0),
                            ),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 92,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.white,
                            fixedSize: Size(92, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(0),
                                right: Radius.circular(30),
                              ),
                            )),
                        onPressed: () {
                          setState(() {
                            if (myController.text != '') {
                              widget.list.add(myController.text);
                              myController.clear();
                            }
                          });
                        },
                        icon: Icon(Icons.add),
                        label: Text(''),
                      ),
                    )
                  ],
                ),
          widget.list.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(t.digiteAs +
                      widget.labelText +
                      t.queEstiverUsando+" \"+\t.paraAdiconarLista),
                )
              : ChipList(widget.list, !widget.readOnly, callback),
        ],
      ),
    );
  }
}

class ChipList extends StatefulWidget {
  final List<String> list;
  final bool deletePerm;
  final Function callback;
  ChipList(this.list, this.deletePerm, this.callback);

  @override
  _ChipListState createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list
          .map((item) => (Container(
                // padding: const EdgeInsets.all(2.0),
                child: widget.deletePerm
                    ? Chip(
                        label: Text(
                          item,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Theme.of(context).accentColor,
                        elevation: 6.0,
                        shadowColor: Colors.grey[60],
                        deleteIcon: Icon(Icons.cancel),
                        onDeleted: () {
                          setState(() {
                            widget.list.remove(item);
                            widget.callback();
                          });
                        },
                      )
                    : Chip(
                        label: Text(
                          item,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Theme.of(context).accentColor,
                        elevation: 6.0,
                        shadowColor: Colors.grey[60],
                      ),
              )))
          .toList(),
    );
  }
}
