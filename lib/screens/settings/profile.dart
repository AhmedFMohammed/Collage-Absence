import 'package:schoolattendance/repository/auth/userAuth.dart';
import 'package:schoolattendance/screens/Stages/AddLesson.dart';
import 'package:schoolattendance/services/models/user.dart';
import 'package:schoolattendance/widgets/cbackbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController Cname = TextEditingController(text: "");
  TextEditingController Cspecialty = TextEditingController(text: "");
  UserModel user = UserModel();
  UserAuth userAuth = UserAuth();
  bool is_EditMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo().whenComplete(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future getInfo() async {
    user = await userAuth.getUserInfo();
    Cname.text = user.username as String;
    Cspecialty.text = user.speciality as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //header
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CBackButton(
                        fnk: () => Navigator.pop(context),
                        color: is_EditMode ? Colors.grey : Color(0xFF5f4a95),
                      ),
                      CBackButton(
                        ICD: !is_EditMode
                            ? FontAwesomeIcons.pen
                            : FontAwesomeIcons.check,
                        fnk: () {
                          setState(() {
                            is_EditMode = !is_EditMode;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //footer
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircleAvatar(
                              backgroundColor: Color(0xFF5f4a95),
                              backgroundImage: user.profilePicture != null
                                  ? MemoryImage(
                                      user.profilePicture as Uint8List)
                                  : null,
                              child: user.profilePicture != null
                                  ? null
                                  : FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 50,
                                    )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          readOnly: !is_EditMode,
                          controller: Cname,
                          hint: "Name",
                        ),
                        CustomTextField(
                          readOnly: !is_EditMode,
                          controller: Cspecialty,
                          hint: "specialty",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
