class Redacteur {
  int? id;
  String nom;
  String prenom;
  String email;

  //Constructeur avec id
  Redacteur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  //Constructeur sans id
  Redacteur.withoutId({
    required this.nom,
    required this.prenom,
    required this.email,
  }) : id = null;

  //Convertir en Map pour SQlite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
    };
  }

  //Créer un objet depuis un Map
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }

  @override
  String toString() {
    return 'Redacteur{id: $id,nom: $nom, prenom: $prenom, email: $email}';
  }
}
