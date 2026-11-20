extension DateTimeToInt on DateTime{
  int toInt() =>
    (year * (year % 4 == 0 ? 366 : 365) + month * (month <= 7 ? (month % 2 == 0 ? (month == 2 ? (year % 4 == 0 ? 29 : 28) : 30) : 31) : month % 2 == 0 ? 31 : 30) + day) * 24 * 60 + hour * 60 + minute;
}