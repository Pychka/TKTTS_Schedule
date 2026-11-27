List<String> getClean(String str) => splitAndClean(str.toLowerCase(), ' ', [',', '.', '(', ')'], toClean: ['/'], toClear: ['-']);

List<String> splitAndClean(
  String str,
  String toSplit,
  List<String>? toRemove, {
  List<String>? toClean,
  List<String>? toClear,
  int minSize = 3,
}) {
  final List<String> result = [];
  str = str.toLowerCase();
  int start = 0;
  String second;
  String? third;
  String ch;

  for (int i = 0; i < str.length; i++) {
    ch = str[i];
    if (ch == toSplit) {
      if (i + 1 < str.length) {
        second = str[i + 1];
        third = i + 2 < str.length ? str[i + 2] : null;

        if ((second == toSplit || third == toSplit) && minSize > i - start) {
          str = str.replaceRange(i, i + 1, '');
          i--;
          continue;
        }

        if (third != toSplit && toRemove != null && toRemove.contains(second)) {
          str = str.replaceRange(i + 1, i + 2, ' ');
          i--;
          continue;
        }

        if (minSize > i - start) {
          str = str.replaceRange(i, i + 1, '');
          i--;
          continue;
        }
      }

      if (start != i) {
        result.add(str.substring(start, i));
        str = str.replaceRange(i, i + 1, '');
        i--;
      }
      start = i + 1;
    }

    if (start == i && toClean?.contains(ch) == true) {
      start = i + 1;
    }

    if (toRemove?.contains(ch) == true) {
      str = str.replaceRange(i, i + 1, ' ');
      i--;
      continue;
    }
  }

  if (start < str.length) {
    result.add(str.substring(start));
  }

  if (toClear != null) {
    for (final String f in List<String>.from(result)) {
      final String q = f.split('').where((c) => !toClear.contains(c)).join();

      if (f != q && !result.contains(q)) {
        result.add(q);
      }

      if (f != q) {
        final subTokens = splitAndClean(
          f,
          toSplit,
          toClear,
          toClean: toClean,
          toClear: null,
          minSize: minSize,
        );
        for (final sub in subTokens) {
          if (!result.contains(sub)) {
            result.add(sub);
          }
        }
      }
    }
  }

  return result;
}
