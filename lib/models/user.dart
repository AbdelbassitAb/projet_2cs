class Transportateur {
  int? idTransportateur;
  String? acessToken;
  String? refreshToken;
  String? nom;
  String? prenom;
  String? date_recrutement; // could be student or parent
  String? type_vehicule;
  int? id_operateur;
  String? photo_transportateur;
  String? email;
  String? mot_de_passe_transportateur;
  String? error;

  Transportateur({
    this.idTransportateur,
    this.acessToken,
    this.refreshToken,
    this.nom,
    this.prenom,
    this.date_recrutement,
    this.type_vehicule,
    this.id_operateur,
    this.photo_transportateur,
    this.email,
    this.mot_de_passe_transportateur,
    this.error,
  });

  factory Transportateur.fromJson(Map<String, dynamic> json) {
    return Transportateur(
      idTransportateur: json["idTransportateur"],
      acessToken: json["acessToken"],
      refreshToken: json["refreshToken"],
      nom: json["nom"],
      prenom: json["prenom"],
      date_recrutement: json["date_recrutement"],
      type_vehicule: json["type_vehicule"],
      id_operateur: json["id_operateur"],
      photo_transportateur: json["photo_transportateur"],
      email: json["email"],
      mot_de_passe_transportateur: json["mot_de_passe_transportateur"],
      error: json["error"],
    );
  }
}
