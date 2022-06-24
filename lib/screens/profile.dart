import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_2cs/config/config.dart';
import 'package:projet_2cs/screens/login.dart';
import 'package:projet_2cs/services/cloud_service.dart';
import 'package:projet_2cs/widgets/all_widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static const route = "/profile";

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Déconnecter"),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("Etes vous sure ?"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Annuler"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:const  Text("Confirmer"),
                onPressed: () async {
                  try {
                    await Provider.of<Auth>(context, listen: false).logOut();
                    Navigator.pushReplacementNamed(context, Login.route);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          );
        },
      );
    }

    final transportateur = Provider.of<Auth>(context).transportateur;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 32),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration:const  BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: transportateur?.photo_transportateur != null
                                ? FadeInImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      transportateur!.photo_transportateur!,
                                    ),
                                    placeholder:const  AssetImage(
                                        "assets/images/placeholder-image.png"),
                                  )
                                :const  CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      size: 70,
                                    ),
                                    backgroundColor: Colors.red,
                                    radius: 50,
                                  ),
                          ),
                        ),
                        const  SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${transportateur?.nom} ${transportateur?.prenom}",
                                style:const TextStyle(
                                    fontSize: 25,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const  SizedBox(
                      height: verticalPadding,
                    ),
                    defaultCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            SettingsItem(
                              info: transportateur?.email ?? '',
                              typeInfo: "Email:",
                            ),
                            const  Divider(
                              thickness: 2,
                            ),
                            SettingsItem(
                              info:  DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                  transportateur?.date_recrutement ??
                                      '')) ,
                              typeInfo: "Date de recrutement:",
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            SettingsItem(
                              info: transportateur?.type_vehicule ?? '',
                              typeInfo: "Type de vehicule:",
                            ),
                            const   Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultButton(
                        context: context,
                        color: const Color(0xFFAB0404),
                        onPressed: () async {
                          await _showMyDialog();
                        },
                        text: "Se déconnecter",
                        showArrow: false,
                        centerText: true,
                        rounded: true),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatefulWidget {
  SettingsItem({required this.info, required this.typeInfo, Key? key})
      : super(key: key);

  String info = '';
  String typeInfo = '';

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.typeInfo,
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    const     SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.info,
                      overflow: TextOverflow.ellipsis,
                      style:const TextStyle(
                        color: appGray,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              // Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
