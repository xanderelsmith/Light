class EventData {
  EventData({required this.date, required this.info, required this.title});
  late String title;
  late String info;
  final DateTime date;
  EventData copyWith({DateTime? newdate, String? newinfo, String? newtitle}) =>
      EventData(
          date: newdate ?? date,
          info: newinfo ?? info,
          title: newtitle ?? title);
  static EventData initial = EventData(
      date: DateTime.now(),
      info:
          'You have Successfully enrolled your school into the Light School management program, Congratulations',
      title: 'Enrollment Day');

  Map<String, dynamic> toJson() => {'title': title, 'info': info, 'date': date};
  EventData fromJson(Map<String, dynamic> item) =>
      EventData(title: item['title'], info: item['info'], date: item['date']);
}
