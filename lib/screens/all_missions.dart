import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:projet_2cs/config/config.dart';
import 'package:projet_2cs/screens/profile.dart';
import 'package:projet_2cs/services/cloud_service.dart';
import 'package:projet_2cs/widgets/all_widgets.dart';
import 'package:provider/provider.dart';

import 'mission_detail.dart';

class AllMission extends StatefulWidget {
  const AllMission({Key? key}) : super(key: key);

  @override
  _AllMissionState createState() => _AllMissionState();
}

class _AllMissionState extends State<AllMission> {
  bool isLoading = true;

  getUserData() async {
    try {
      await Provider.of<Auth>(context, listen: false).getMissions();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('test');
      print(e);
      errorSnackBar(context, "Connecting...");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final transportateur = Provider.of<Auth>(context).transportateur;

    return Scaffold(
        body: SafeArea(
            child: SizedBox(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: horizontalPadding,
                        right: horizontalPadding,
                        top: verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Bonjour!',
                              style:
                              TextStyle(color: Colors.grey, fontSize: 30),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const Profile()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: transportateur
                                      ?.photo_transportateur !=
                                      null
                                      ? FadeInImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      transportateur!
                                          .photo_transportateur!,
                                    ),
                                    height: 30,
                                    width: 30,
                                    placeholder: const AssetImage(
                                      "assets/images/placeholder-image.png",
                                    ),
                                  )
                                      : const CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    backgroundColor: Colors.red,
                                    radius: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.notifications,
                              size: 30,
                              color: secondaryColor,
                            ),
                          ],
                        ),
                         Text(
                          transportateur?.prenom ?? '' + ',',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Mission:',
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: Provider
                                .of<Auth>(context)
                                .missions
                                ?.missions!
                                .length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                         MissionDetail(mission: Provider
                                             .of<Auth>(context)
                                             .missions
                                             ?.missions![index],)),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: primaryColor,
                                      )),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Column(
                                    children: [
                                      CardInfo(
                                        icon: "assets/images/person.png",
                                        info: "${Provider
                                            .of<Auth>(context)
                                            .missions
                                            ?.missions![index]
                                            .nom_patient} ${ Provider
                                            .of<Auth>(context)
                                            .missions
                                            ?.missions![index]
                                            .prenom_patient}"
                                        ,
                                      ),
                                      CardInfo(
                                        icon: "assets/images/calendar.png",
                                        info: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                            Provider.of<Auth>(context)
                                                .missions
                                                ?.missions![index]
                                                .date_mission
                                                .toString() ??
                                                "2020-01-02")) ,
                                      ),
                                      CardInfo(
                                        icon: "assets/images/clock.png",
                                        info: "${ Provider.of<Auth>(context)
                                            .missions
                                            ?.missions![index]
                                            .heure_depart}",
                                      ),
                                      CardInfo(
                                        icon: "assets/images/location.png",
                                        info: "${ Provider.of<Auth>(context)
                                            .missions
                                            ?.missions![index]
                                            .adresse_depart}",
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )))));
    ;
  }
}

class CardInfo extends StatelessWidget {
  CardInfo({
    this.icon = '',
    this.info = '',
    Key? key,
  }) : super(key: key);

  String icon;
  String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Image.asset(icon),
          const SizedBox(
            width: 10,
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
