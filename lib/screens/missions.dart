import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:projet_2cs/config/config.dart';
import 'package:projet_2cs/screens/login.dart';
import 'package:projet_2cs/screens/profile.dart';
import 'package:projet_2cs/services/cloud_service.dart';
import 'package:projet_2cs/widgets/all_widgets.dart';
import 'package:provider/provider.dart';

class Missions extends StatefulWidget {
  static const route = "/missions";

  const Missions({Key? key}) : super(key: key);

  @override
  _MissionsState createState() => _MissionsState();
}

class _MissionsState extends State<Missions> {
  int currentIndex = 0;
  final _formKey = GlobalKey<FormState>();
  XFile? convention;
  XFile? itin;
  bool noConvention = false;
  bool noItin = false;
  DateTime? date;
  String? attente = "";
  String? num_carte = "";

  void incrimentIndex() {
    setState(() {
      currentIndex++;
    });
  }

  void validateForm() async {
    setState(() {
      noConvention = convention == null;
      noItin = itin == null;
    });
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate() && !noConvention && !noItin) {
      setState(() {
        isLoading = true;
      });
      final url = await Provider.of<Auth>(context, listen: false)
          .completeMission(num_carte!, attente!, convention!, itin!);
      setState(() {
        isLoading = false;
        currentIndex++;
      });
    }
  }

  bool isLoading = true;

  getUserData() async {
    try {
      await Provider.of<Auth>(context, listen: false).getMissions();
      Provider.of<Auth>(context, listen: false)
          .missions
      !.missions![0]
          .nom_patient !=
          null && Provider.of<Auth>(context, listen: false)
          .missions
      !.missions![0]
          .mission_effectue == false
          ? currentIndex = 0
          : currentIndex = 3;
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
    List<Widget> tabs = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultButton(
              onPressed: () {
                date = DateTime.now();
                setState(() {
                  currentIndex++;
                });
              },
              context: context,
              text: 'Lancer la mission',
              showArrow: true),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Vous avez une missions programmés pour :',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          InformationCard(
            info:
                Provider.of<Auth>(context).missions?.missions![0].nom_patient ??
                    "",
            infoType: "Nom",
          ),
          InformationCard(
            info: Provider.of<Auth>(context)
                    .missions
                    ?.missions![0]
                    .prenom_patient ??
                "",
            infoType: "Prénom",
          ),
          InformationCard(
            info: Provider.of<Auth>(context)
                    .missions
                    ?.missions![0]
                    .date_mission ??
                "",
            infoType: "Date mission",
          ),
          InformationCard(
            info: Provider.of<Auth>(context)
                    .missions
                    ?.missions![0]
                    .heure_depart ??
                "",
            infoType: "Heure départ",
          ),
          InformationCard(
            info: Provider.of<Auth>(context)
                    .missions
                    ?.missions![0]
                    .adresse_depart ??
                "",
            infoType: "Adresse départ",
          ),
          InformationCard(
            info: Provider.of<Auth>(context)
                    .missions
                    ?.missions![0]
                    .adresse_arrive ??
                "",
            infoType: "Adresse arrivé",
          ),
          InformationCard(
            info: Provider.of<Auth>(context)
                    .missions
                    ?.missions![0]
                    .nombre_patient
                    .toString() ??
                "",
            infoType: "Nombre de patient",
          ),
          InformationCard(
            info: Provider.of<Auth>(context).missions?.missions![0].attente! ??
                    false
                ? "Oui"
                : "non",
            infoType: "Attente",
          )
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultButton(
              onPressed: () async {
                validateForm();
              },
              context: context,
              text: 'Terminer la mission',
              showArrow: true),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultTextFormField(
                    label: "Temps d'attente",
                    hint: "Temps d'attente (min)",
                    keyboardType: TextInputType.number,
                    onSaved: (val) {
                      setState(() {
                        attente = val;
                      });
                    }),
                const SizedBox(height: 20),
                defaultTextFormField(
                    label: "Num de carte id du patient",
                    hint: "ex:826320635",
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == '' || val == null) {
                        return "please enter the identity card";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      print(val);
                      setState(() {
                        num_carte = val;
                      });
                    }),
                const SizedBox(height: 20),
                defaultFileFieled(
                  text: convention == null
                      ? 'Importer la convention'
                      : convention!.name,
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    try {
                      var file = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 50);

                      if (file != null) {
                        setState(() {
                          convention = file;
                        });
                      }
                    } catch (e) {}
                  },
                ),
                noConvention
                    ? const Center(
                        child: Text(
                          'importer une convention svp',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                defaultFileFieled(
                  text: itin == null
                      ? 'Importer l\'image de l\'itinéraire'
                      : itin!.name,
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    try {
                      var file = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 50);

                      if (file != null) {
                        setState(() {
                          itin = file;
                        });
                      }
                    } catch (e) {}
                  },
                ),
                noItin
                    ? const Center(
                        child: Text(
                          'importer l\'image de l\'itinéraire svp',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Lottie.asset("assets/images/done.json",
                  height: MediaQuery.of(context).size.width * 0.5)),
          defaultButton(
              onPressed: () {
                setState(() {

                  Provider.of<Auth>(context, listen: false)
                              .missions
                              !.missions![0]
                              .nom_patient !=
                          null && Provider.of<Auth>(context, listen: false)
                      .missions
                  !.missions![0]
                      .mission_effectue == false
                      ? currentIndex = 0
                      : currentIndex++;
                });
              },
              context: context,
              text: 'Retourner',
              showArrow: true),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Informations de la missions:',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          InformationCard(
            info: "12 km",
            infoType: "Kilometrage",
          ),
          InformationCard(
            info: "9:15 am",
            infoType: "Heure de début",
          ),
          InformationCard(
            info: "10:20 am",
            infoType: "Heure de fin",
          ),
          InformationCard(
            info: "10/04/2022",
            infoType: "Date",
          ),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Lottie.asset(
            "assets/images/list.json", /*  height: MediaQuery.of(context).size.width * 0.5*/
          )),
          const Text(
            'Vous n\'avez aucune mission',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      // const TeacherProfileTab(),
    ];
    final transportateur = Provider.of<Auth>(context).transportateur;

    return Scaffold(
        body: SafeArea(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: SizedBox(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: verticalPadding),
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
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 30),
                                    ),
                                    const Spacer(),
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
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                currentIndex == 3
                                    ? const SizedBox()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          StepperCard(
                                              number: 1,
                                              text: "Lancement de mission",
                                              selected: currentIndex == 0),
                                          const CustomSeparator(),
                                          StepperCard(
                                              number: 2,
                                              text: "Arrivage au structure",
                                              selected: currentIndex == 1),
                                          const CustomSeparator(),
                                          StepperCard(
                                              number: 3,
                                              text: "Mission terminé",
                                              selected: currentIndex == 2),
                                        ],
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                tabs[currentIndex],
                              ],
                            ))))));
  }
}

class StepperCard extends StatelessWidget {
  StepperCard(
      {this.text = '', this.number = 1, this.selected = false, Key? key})
      : super(key: key);
  int number;
  String text;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: selected ? secondaryColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: !selected ? secondaryColor : Colors.white,
                  width: 1,
                )),
            child: Text(
              number.toString(),
              style: TextStyle(
                  color: !selected ? secondaryColor : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class CustomSeparator extends StatelessWidget {
  const CustomSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        // padding: const EdgeInsets.only(top: 50),
        height: 5,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  InformationCard({this.info = "", this.infoType = "", Key? key})
      : super(key: key);

  String infoType;
  String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '$infoType: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 22,
              )),
          TextSpan(
              text: '$info .',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 22,
              )),
        ]),
      ),
    );
  }
}
