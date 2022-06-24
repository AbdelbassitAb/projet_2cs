import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_2cs/config/config.dart';
import 'package:projet_2cs/models/missions.dart';
import 'package:projet_2cs/screens/missions.dart';

class MissionDetail extends StatefulWidget {
  MissionDetail({this.mission, Key? key}) : super(key: key);

  MissionModel? mission;

  @override
  _MissionDetailState createState() => _MissionDetailState();
}

class _MissionDetailState extends State<MissionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Details de la mission:',
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InformationCard(
                    info: widget.mission?.nom_patient ?? "",
                    infoType: "Nom",
                  ),
                  InformationCard(
                    info: widget.mission?.prenom_patient ?? "",
                    infoType: "Prénom",
                  ),
                  InformationCard(
                    info: DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        widget.mission?.date_mission.toString() ?? "")),
                    infoType: "Date mission",
                  ),
                  InformationCard(
                    info: widget.mission?.heure_depart ?? "",
                    infoType: "Heure départ",
                  ),
                  InformationCard(
                    info: widget.mission?.adresse_depart ?? "",
                    infoType: "Adresse départ",
                  ),
                  InformationCard(
                    info: widget.mission?.adresse_arrive ?? "",
                    infoType: "Adresse arrivé",
                  ),
                  InformationCard(
                    info: widget.mission?.nombre_patient.toString() ?? "",
                    infoType: "Nombre de patient",
                  ),
                  InformationCard(
                    info: widget.mission?.kilometrage.toString() ?? "",
                    infoType: "Kilometrage",
                  ),
                  InformationCard(
                    info: widget.mission?.attente! ?? false ? "Oui" : "non",
                    infoType: "Attente",
                  ),
                  InformationCard(
                    info: widget.mission?.temps_attente ?? "",
                    infoType: "Temps d\'attente",
                  ),
                  const Text('Capture d\'itinéraire: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 22,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: widget.mission?.image_liteneraire != null
                        ? FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.mission?.image_liteneraire ?? "",
                            ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
