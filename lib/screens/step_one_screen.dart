import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../utils/validators.dart';
import 'step_two_screen.dart';

class StepOneScreen extends StatefulWidget {
  const StepOneScreen({super.key});
  @override
  State<StepOneScreen> createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  final _form = GlobalKey<FormState>();
  final _confirmField = GlobalKey<FormFieldState<String>>();
  final _nom = TextEditingController();
  final _prenom = TextEditingController();
  final _email = TextEditingController();
  final _mdp = TextEditingController();
  final _confirm = TextEditingController();
  bool _cache = true;

  @override
  void dispose() {
    for (final c in [_nom, _prenom, _email, _mdp, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  void _next() {
    if (!_form.currentState!.validate()) return;
    final p = UserProfile(
      nom: _nom.text.trim(), prenom: _prenom.text.trim(),
      email: _email.text.trim(), password: _mdp.text,
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => StepTwoScreen(profil: p)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription - Étape 1/3'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 1 / 3),
        ),
      ),
      body: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nom,
              decoration: const InputDecoration(labelText: 'Nom', prefixIcon: Icon(Icons.person)),
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.nom(v, 'Le nom'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prenom,
              decoration: const InputDecoration(labelText: 'Prénom', prefixIcon: Icon(Icons.badge)),
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.nom(v, 'Le prénom'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email)),
              textInputAction: TextInputAction.next,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mdp,
              obscureText: _cache,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                helperText: '8 car. min, 1 majuscule, 1 chiffre',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_cache ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _cache = !_cache),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: Validators.motDePasse,
              // revalide la confirmation si le mot de passe change
              onChanged: (_) {
                if (_confirm.text.isNotEmpty) _confirmField.currentState?.validate();
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: _confirmField,
              controller: _confirm,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Confirmer le mot de passe', prefixIcon: Icon(Icons.lock_reset)),
              validator: (v) => Validators.confirmation(v, _mdp.text),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _next, child: const Text('Suivant')),
          ],
        ),
      ),
    );
  }
}