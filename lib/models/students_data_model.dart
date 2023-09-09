class StudentsModel {
  StudentsModel(
      {required this.imgurl,
      required this.id,
      required this.gender,
      required this.name,
      required this.surname,
      required this.address,
      required this.fatherName,
      required this.motherName,
      required this.phoneNumber,
      required this.studentclass,
      required this.religion,
      required this.dateofbirth,
      required this.email,
      required this.age});
  final String name;
  final String surname;
  final String imgurl;
  final int id;
  final String religion;
  final int age;
  final String email;
  final int phoneNumber;
  final String fatherName;
  final String motherName;
  final String address;
  final DateTime dateofbirth;
  final String gender;
  final String studentclass;
}
