import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import 'step_one_screen.dart';

class SummaryScreen extends StatefulWidget {
  final UserProfile profil;
  const SummaryScreen({super.key, required this.profil});
  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _form = GlobalKey<FormState>();

  void _restart() => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const StepOneScreen()),
        (_) => false,
      );

  Future<void> _reset() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Réinitialiser ?'),
        content: const Text('Les données saisies seront perdues.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Oui')),
        ],
      ),
    );
    if (ok == true && mounted) _restart();
  }

  Future<void> _confirm() async {
    if (!_form.currentState!.validate()) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (c) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('Compte créé !'),
        content: Text('Bienvenue ${widget.profil.prenom}.'),
        actions: [FilledButton(onPressed: () => Navigator.pop(c), child: const Text('Terminer'))],
      ),
    );
    if (mounted) _restart();
  }

  Widget _card(String titre, Map<String, String> lignes) => Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(titre, style: Theme.of(context).textTheme.titleMedium),
            ),
            for (final e in lignes.entries)
              ListTile(
                title: Text(e.key),
                subtitle: Text(e.value.isEmpty ? 'Non renseigné' : e.value),
              ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final p = widget.profil;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Récapitulatif de votre profil'),
        actions: [IconButton(icon: const Icon(Icons.restart_alt), onPressed: _reset)],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _card('Identité', {
              'Nom complet': p.nomComplet,
              'E-mail': p.email,
              'Mot de passe': '•' * p.password.length, // jamais en clair
            }),
            _card('Profil professionnel', {
              'Profession': p.profession,
              'Expérience': '${p.experience} an(s)',
              'TJM': '${p.tjm.toStringAsFixed(2)} €',
              'Biographie': p.biographie,
            }),
            // Case à cocher obligatoire = FormField<bool>
            FormField<bool>(
              initialValue: false,
              validator: (v) => v == true ? null : 'Vous devez accepter les conditions',
              builder: (f) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    value: f.value,
                    onChanged: f.didChange,
                    title: const Text("J'accepte les conditions"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  if (f.hasError)
                    Text(f.errorText!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _confirm, child: const Text('Confirmer et créer le compte')),
          ],
        ),
      ),
    );
  }
}