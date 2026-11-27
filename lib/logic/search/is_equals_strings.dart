
import 'dart:math';

import 'package:collection/collection.dart';


double isEqualsString(
  String a,
  String b, {
  required List<String> first,
  required List<String> second,
  double coefficient = 0.7,
}) {
  b = b.toLowerCase();
  if (a.startsWith(b)) return 1.1;

  if (second.isEmpty) return 1.1;

  if (first.isEmpty) return 0.0;

  List<double> ks = [];
  final List<bool> used = List<bool>.filled(first.length, false);

  for (final queryWord in second) {
    int bestIdx = -1;
    double bestK = 0.0;

    for (int i = 0; i < first.length; i++) {
      if (used[i]) continue;
      final k = _isEqualsStrings(first[i], queryWord);
      if (k > bestK) {
        bestK = k;
        bestIdx = i;
      }
    }

    if (bestIdx == -1 || bestK < coefficient) return 0.0;

    used[bestIdx] = true;
    ks.add(bestK);
  }
  final average = ks.sum / second.length;
  final geometric = pow(ks.fold(1.0, (acc, item) => acc * item), 1 / second.length);

  return (average + geometric) / 2; 
}


double _isEqualsStrings(String target, String query, {double min = 0.7}) {
  if (query.isEmpty || target.isEmpty) return 0.0;
  if (target.startsWith(query)) return 1.1;

  final int window = max(2, (target.length ~/ 2) - 1);
  final double k = (1 / query.length);
  if (query.length > target.length + window) return 0.0;

  double maxPossibleWeight = 0.0;
  double earnedWeight = 0.0;
  final List<bool> used = List<bool>.filled(target.length, false);

  for (int i = 0; i < query.length; i++) {
    final String ch = query[i];
    final double charImportance = (i == 0) ? 1.5 : 1.0;
    maxPossibleWeight += charImportance;

    if (i < target.length && !used[i] && ch == target[i]) {
      earnedWeight += charImportance;
      used[i] = true;
      continue;
    }

    final int code = ch.codeUnitAt(0);
    if (code >= 48 && code <= 57){
      earnedWeight -= 1;
      continue;
    }
    bool isFounded = false;
    for (int c = 1; c <= window; c++) {
      final double distancePenalty = 1.0 - (c / (window + 1));

      if (i + c < target.length && !used[i + c] && target[i + c] == ch) {
        earnedWeight += charImportance * distancePenalty;
        used[i + c] = true;
        isFounded = true;
        break;
      }

      if (i - c >= 0 && i - c < target.length && !used[i - c] && target[i - c] == ch) {
        earnedWeight += charImportance * distancePenalty;
        used[i - c] = true;
        isFounded = true;
        break;
      }
    }
    if(!isFounded) earnedWeight -= k * 2;
  }

  return earnedWeight / maxPossibleWeight;
}