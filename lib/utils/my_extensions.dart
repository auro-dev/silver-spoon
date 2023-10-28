///
/// Created by Auro on 30/04/23 at 7:49 AM
///

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}

extension DateTimeExtension on DateTime {
  DateTime withTime([int hour = 0, int minute = 0]) =>
      DateTime(this.year, this.month, this.day, hour, minute);

  DateTime withDate([int year = 0, int month = 0, int day = 0]) => DateTime(
      year, month, day, this.hour, this.minute, this.second, this.millisecond);

  bool isAfterOrEqual(DateTime other) {
    return isAtSameMomentAs(other) || isAfter(other);
  }

  bool isBeforeOrEqual(DateTime other) {
    return isAtSameMomentAs(other) || isBefore(other);
  }

  bool isBetween({required DateTime from, required DateTime to}) {
    return isAfterOrEqual(from) && isBeforeOrEqual(to);
  }

  bool isBetweenExclusive({required DateTime from, required DateTime to}) {
    return isAfter(from) && isBefore(to);
  }
}
