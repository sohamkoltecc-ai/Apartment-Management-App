import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:my_apart/chat/Admin/widgets/widgets_admin.dart';

import '../service/database_service_admin.dart';
import 'group_page_admin.dart';

class GroupInfoAdmin extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;

  const GroupInfoAdmin({
    Key? key,
    required this.adminName,
    required this.groupName,
    required this.groupId,
  }) : super(key: key);

  @override
  State<GroupInfoAdmin> createState() => _GroupInfoAdminState();
}

class _GroupInfoAdminState extends State<GroupInfoAdmin> {
  Stream? members;

  @override
  void initState() {
    super.initState();
    getMembers();
  }

  // Get group members
  void getMembers() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      debugPrint("User is not logged in");
      return;
    }

    DatabaseServiceAdmin(uid: user.uid).getGroupMembers(widget.groupId).then((
      val,
    ) {
      if (mounted) {
        setState(() {
          members = val;
        });
      }
    });
  }

  // Get member name
  String getName(String r) {
    if (!r.contains("_")) {
      return r;
    }

    return r.substring(r.indexOf("_") + 1);
  }

  // Get member ID
  String getId(String res) {
    if (!res.contains("_")) {
      return res;
    }

    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffF9A826),
        title: const Text("Group Info"),
        actions: [
          IconButton(
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;

              if (user == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please login first")),
                );
                return;
              }

              AwesomeDialog(
                context: context,
                animType: AnimType.scale,
                dialogType: DialogType.question,
                body: const Center(
                  child: Text(
                    "Are you sure you want to exit the group?",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  DatabaseServiceAdmin(uid: user.uid)
                      .toggleGroupJoin(
                        widget.groupId,
                        getName(widget.adminName),
                        widget.groupName,
                      )
                      .whenComplete(() {
                        if (mounted) {
                          nextScreenReplace(context, const GroupPageAdmin());
                        }
                      });
                },
              ).show();
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
        ],
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Group information
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueGrey.withOpacity(0.2),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      widget.groupName.isNotEmpty
                          ? widget.groupName.substring(0, 1).toUpperCase()
                          : "?",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.groupName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Admin: ${getName(widget.adminName)}",
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Members
            Expanded(child: memberList()),
          ],
        ),
      ),
    );
  }

  // Member list
  Widget memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }

        // No members
        if (snapshot.data['members'] == null ||
            snapshot.data['members'].isEmpty) {
          return const Center(
            child: Text(
              "NO MEMBERS",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }

        // Members list
        return ListView.builder(
          itemCount: snapshot.data['members'].length,
          itemBuilder: (context, index) {
            String member = snapshot.data['members'][index];

            String memberName = getName(member);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey,
                  child: Text(
                    memberName.isNotEmpty
                        ? memberName.substring(0, 1).toUpperCase()
                        : "?",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  memberName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
