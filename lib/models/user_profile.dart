class UserProfile {
  final String nom, prenom, email, password, profession, biographie;
  final int experience;
  final double tjm;

  const UserProfile({
    this.nom = '', this.prenom = '', this.email = '', this.password = '',
    this.profession = '', this.biographie = '',
    this.experience = 0, this.tjm = 0,
  });

  UserProfile copyWith({
    String? nom, String? prenom, String? email, String? password,
    String? profession, String? biographie, int? experience, double? tjm,
  }) => UserProfile(
        nom: nom ?? this.nom,
        prenom: prenom ?? this.prenom,
        email: email ?? this.email,
        password: password ?? this.password,
        profession: profession ?? this.profession,
        biographie: biographie ?? this.biographie,
        experience: experience ?? this.experience,
        tjm: tjm ?? this.tjm,
      );

  String get nomComplet => '$prenom ${nom.toUpperCase()}';
}