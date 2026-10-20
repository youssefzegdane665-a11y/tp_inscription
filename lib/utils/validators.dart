class Validators {
  static final _lettres = RegExp(r"^[A-Za-zÀ-ÿ' -]+$");
  static final _mail = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)*\.[a-zA-Z]{2,}$');

  static String? nom(String? v, [String champ = 'Ce champ']) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return '$champ est obligatoire';
    if (s.length < 2) return '$champ : 2 caractères minimum';
    if (!_lettres.hasMatch(s)) return '$champ : lettres uniquement';
    return null;
  }

  static String? email(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return "L'e-mail est obligatoire";
    return _mail.hasMatch(s) ? null : 'Format : nom@domaine.com';
  }

  static String? motDePasse(String? v) {
    final s = v ?? '';
    if (s.isEmpty) return 'Mot de passe obligatoire';
    if (s.length < 8) return 'Au moins 8 caractères';
    if (!s.contains(RegExp(r'[A-Z]'))) return 'Au moins une majuscule';
    if (!s.contains(RegExp(r'\d'))) return 'Au moins un chiffre';
    return null;
  }

  static String? confirmation(String? v, String original) {
    if (v == null || v.isEmpty) return 'Confirmez le mot de passe';
    return v == original ? null : 'Les mots de passe diffèrent';
  }

  static String? profession(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Profession obligatoire';
    return s.length < 2 ? 'Profession trop courte' : null;
  }

  static String? experience(String? v) {
    final n = int.tryParse((v ?? '').trim());
    if (n == null) return "Entier attendu";
    return (n < 0 || n > 50) ? 'Entre 0 et 50' : null;
  }

  static String? tjm(String? v) {
    final n = double.tryParse((v ?? '').trim().replaceAll(',', '.'));
    if (n == null) return 'Montant invalide';
    return (n < 50 || n > 3000) ? 'Entre 50 € et 3000 €' : null;
  }

  // Facultative : vide = OK, sinon 20 caractères minimum
  static String? biographie(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return null;
    return s.length < 20 ? 'Au moins 20 caractères ou laissez vide' : null;
  }
}