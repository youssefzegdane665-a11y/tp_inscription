import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_profile.dart';
import '../utils/validators.dart';
import 'summary_screen.dart';

class StepTwoScreen extends StatefulWidget {
  final UserProfile profil;
  const StepTwoScreen({super.key, required this.profil});
  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final _form = GlobalKey<FormState>();
  final _prof = TextEditingController();
  final _exp = TextEditingController();
  final _tjm = TextEditingController();
  final _bio = TextEditingController();

  @override
  void dispose() {
    for (final c in [_prof, _exp, _tjm, _bio]) {
      c.dispose();
    }
    super.dispose();
  }

  void _next() {
    if (!_form.currentState!.validate()) return;
    final complet = widget.profil.copyWith(
      profession: _prof.text.trim(),
      experience: int.parse(_exp.text.trim()),
      tjm: double.parse(_tjm.text.trim().replaceAll(',', '.')),
      biographie: _bio.text.trim(),
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SummaryScreen(profil: complet)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        title: const Text('Profil Professionnel - Étape 2/3'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 2 / 3),
        ),
      ),
      body: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _prof,
              decoration: const InputDecoration(labelText: 'Profession', prefixIcon: Icon(Icons.work)),
              validator: Validators.profession,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _exp,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(labelText: "Années d'expérience", prefixIcon: Icon(Icons.timeline)),
              validator: Validators.experience,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tjm,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d{0,2}'))],
              decoration: const InputDecoration(labelText: 'TJM', suffixText: '€', prefixIcon: Icon(Icons.euro)),
              validator: Validators.tjm,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bio,
              maxLength: 300,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Biographie (facultative)', alignLabelWithHint: true),
              validator: Validators.biographie,
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _next, child: const Text('Suivant')),
          ],
        ),
      ),
    );
  }
}