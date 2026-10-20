import 'package:flutter_test/flutter_test.dart';
import 'package:tp_inscription/utils/validators.dart';

void main() {
  test('email invalide', () => expect(Validators.email('ali@gmail'), isNotNull));
  test('email valide', () => expect(Validators.email('ali@gmail.com'), isNull));
  test('mdp sans majuscule', () => expect(Validators.motDePasse('bonjour12'), isNotNull));
  test('mdp valide', () => expect(Validators.motDePasse('Bonjour12'), isNull));
  test('confirmation différente', () => expect(Validators.confirmation('a', 'b'), isNotNull));
  test('expérience > 50', () => expect(Validators.experience('51'), isNotNull));
  test('TJM avec virgule', () => expect(Validators.tjm('350,50'), isNull));
  test('TJM trop bas', () => expect(Validators.tjm('20'), isNotNull));
  test('bio vide valide', () => expect(Validators.biographie(''), isNull));
  test('bio trop courte', () => expect(Validators.biographie('Je code.'), isNotNull));
}