String capitalise(String string) {
  RegExp smallCaseRegExp = new RegExp(
    r'(^[a-z]|[\s\-][a-z])',
  );
  String capitalisedString = string.replaceAllMapped(smallCaseRegExp, (match) {
    return match.group(0).toUpperCase();
  });
  return capitalisedString;
}

String splitCamelCase(String string) {
  RegExp smallCaseRegExp = new RegExp(
    r'([a-z][A-Z])',
  );
  String capitalisedString = string.replaceAllMapped(smallCaseRegExp, (match) {
    return '${match.group(0)[0]} ${match.group(0)[1]}';
  });
  return capitalisedString;
}
