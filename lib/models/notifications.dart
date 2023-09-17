import 'dart:io';

class ActiveNotification {
  const ActiveNotification({
    this.image,
    required this.createdDate,
    required this.title,
    required this.description,
  });
  final String title;
  final DateTime createdDate;
  final File? image;
  final String description;
  ActiveNotification copyWith(
          {DateTime? newCreatedDate,
          String? newDescription,
          String? newTitle}) =>
      ActiveNotification(
          createdDate: newCreatedDate ?? createdDate,
          description: newDescription ?? description,
          title: newTitle ?? title);
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'createdDate': createdDate,
      };
  ActiveNotification fromJson(Map<String, dynamic> item) => ActiveNotification(
      title: item['title'],
      description: item['description'],
      createdDate: item['createdDate']);
  static ActiveNotification initial = ActiveNotification(
    createdDate: DateTime.now(),
    description: '',
    title: '',
  );
}
