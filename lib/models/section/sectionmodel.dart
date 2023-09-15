class Section {
  Section(
      {required this.createdDate,
      required this.description,
      required this.name});
  late String name;
  late String description;
  final DateTime createdDate;
  static Section initial =
      Section(createdDate: DateTime.now(), description: '', name: '');
  Section copyWith(
          {DateTime? newCreatedDate,
          String? newDescription,
          String? newname}) =>
      Section(
          createdDate: newCreatedDate ?? createdDate,
          description: newDescription ?? description,
          name: newname ?? name);

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'createdDate': createdDate};
  Section fromJson(Map<String, dynamic> item) => Section(
      name: item['name'],
      description: item['description'],
      createdDate: item['createdDate']);
}
