
class MissionsModel {
  MissionsModel({
    this.missions,
  });

  List<MissionModel>? missions ;

  factory MissionsModel.fromJson(dynamic json) {
    List patients = json as List;

    print(patients);

    List<MissionModel> tempMissions = [];
    json.forEach((day) => tempMissions.add(MissionModel.fromJson(day)));


    return MissionsModel(missions: tempMissions);
  }


}

class MissionModel {
  MissionModel({
    this.nom_patient,
    this.prenom_patient,
    this.date_mission,
    this.heure_depart,
    this.adresse_depart,
    this.adresse_arrive,
    this.nombre_patient,
    this.attente,
    this.temps_attente,
    this.nom_transportateur,
    this.prenom_transportateur,
    this.idmission,
    this.num_carte_id_patient,
    this.convention_url,
    this.image_liteneraire,
    this.mission_effectue,
    this.kilometrage,
  });

  String? nom_patient;
  String? prenom_patient;
  String? date_mission;
  String? heure_depart;
  String? adresse_depart;
  String? adresse_arrive;
  int? nombre_patient;
  bool? attente;
  String? temps_attente;
  String? nom_transportateur;
  String? prenom_transportateur;
  int? idmission;
  int? num_carte_id_patient;
  String? convention_url;
  String? image_liteneraire;
  bool? mission_effectue;
  String? kilometrage;

  factory MissionModel.fromJson(dynamic json) => MissionModel(
    nom_patient: json["nom_patient"],
    prenom_patient: json["prenom_patient"],
    date_mission: json["date_mission"],
    heure_depart: json["heure_depart"],
    adresse_depart: json["adresse_depart"],
    adresse_arrive: json["adresse_arrive"],
    nombre_patient: json["nombre_patient"],
    attente: json["attente"],
    temps_attente: json["temps_attente"],
    nom_transportateur: json["nom_transportateur"],
    prenom_transportateur: json["prenom_transportateur"],
    idmission: json["idmission"],
    num_carte_id_patient: json["num_carte_id_patient"],
    convention_url: json["convention_url"],
    image_liteneraire: json["image_liteneraire"],
    mission_effectue: json["mission_effectue"],
    kilometrage: json["kilometrage"].toString(),
  );

}
