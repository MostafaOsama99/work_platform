import 'package:flutter/material.dart';
import 'package:project/widgets/task/add_teams_button.dart';
import 'package:project/widgets/task/description_widget.dart';
import 'package:project/widgets/task/editTextField_method.dart';
import '../widgets/custom_expansion_title.dart' as custom;

import '../constants.dart';

class EditTeamScreen extends StatefulWidget {
  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final _nameController = TextEditingController();

  var names = [
    'Ahmed Mohamed',
    'Mostafa Osama',
    'Mohamed Hesham',
    'Yousef Essam',
    'Mahmoud Yousef',
    'Beshoy Wagdy',
    'Habiba Sayed'
  ];

  var description = '''this an example of a l
    ''';

  List<Widget> users;

  @override
  void initState() {
    super.initState();
    users = List.generate(names.length, (index) => _userTile(names[index]));
    //names.forEach((name) => users.add(_userTile(name)));
    _nameController.text = 'Team Name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KAppBarHeight),
        child: ClipRRect(
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(KAppBarRound), bottomRight: Radius.circular(KAppBarRound)),
          child: AppBar(
            leading: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                )),
            title: Text('Edit Team'),
            centerTitle: true,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          SizedBox(
            height: 40,
            child: TextField(
                readOnly: true,
                controller: _nameController,
                decoration: TEXT_FIELD_DECORATION_2.copyWith(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  suffixIcon: IconButton(
                      splashRadius: 20,
                      splashColor: Color.fromRGBO(8, 77, 99, 1),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          editTextField(context, _nameController);
                        });
                      }),
                )),
          ),
          Divider(height: 16, indent: 30, endIndent: 30),
          DescriptionWidget(description, isEditing: true),
          Divider(height: 16, indent: 30, endIndent: 30),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6),
            child: Text('Members', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ),
          ...users,
          Divider(height: 16, indent: 30, endIndent: 30),

          /*
          * Invite Members
          */
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8.0, bottom: 4),
            child: Row(
              children: [
                Transform.rotate(
                    angle: 3.14 / 1.45,
                    child: Icon(
                      Icons.link_outlined,
                      size: 25,
                      color: Colors.white70,
                    )),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Invite Members to this team:', style: TextStyle(fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 16),
                      child: Text('#TeamCode7854',
                          style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.white70)),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 22,
                  icon: Icon(Icons.share),
                  onPressed: () {},
                  splashRadius: 18,
                )
              ],
            ),
          ),

          /*
          * add team
          */

          custom.ExpansionTile(
            headerBackgroundColor: COLOR_ACCENT,
            backgroundColor: COLOR_BACKGROUND.withOpacity(0.8),
            iconColor: Colors.white,
            title: Text('Create Team below this', style: TS_TITLE),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      hintText: 'Name',
                      errorStyle: TextStyle(height: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  onFieldSubmitted: (_) {},
                  decoration: TEXT_FIELD_DECORATION_2.copyWith(
                    hintText: 'Description',
                  ),
                ),
              ),
              SizedBox(height: 48, child: FittedBox(child: addTeamsButton(hintText: "Create Team", onPressed: () {}))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userTile(String name) {
    var lastLitter = name.indexOf(' ') + 1;
    return GestureDetector(
      onLongPress: () {
        //TODO: show popup menu
        //https://stackoverflow.com/questions/54300081/flutter-popupmenu-on-long-press
        //or use 3 dot drop down menu
        //https://stackoverflow.com/questions/58144948/easiest-way-to-add-3-dot-pop-up-menu-appbar-in-flutter
      },
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: COLOR_BACKGROUND,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              child: Text(name[0] + name[lastLitter], style: TextStyle(fontSize: 16)),
              backgroundColor: COLOR_ACCENT,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name, style: TextStyle(fontSize: 15)),
                Text('@UserName', style: TextStyle(fontSize: 13, color: Colors.grey))
              ],
            ),
            Spacer(),
            Text('job title'),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
