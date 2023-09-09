import 'package:flutter/material.dart';

import 'package:light/db_handler/db_services/api_services.dart';

import '../repository/studentrepository.dart';

/// The application that contains datagrid on it.
class ViewStudentsScreen extends StatefulWidget {
  const ViewStudentsScreen({Key? key}) : super(key: key);

  @override
  State<ViewStudentsScreen> createState() => _ViewStudentsScreenState();
}



class _ViewStudentsScreenState extends State<ViewStudentsScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}




// /// The application that contains datagrid on it.
// class ViewStudentsScreen extends StatefulWidget {
//   const ViewStudentsScreen({Key? key}) : super(key: key);

//   @override
//   State<ViewStudentsScreen> createState() => _ViewStudentsScreenState();
// }

// final studentsListProvider = FutureProvider<List<ParseObject>>((ref) async {
//   final users = await ApiService.pullUsers();
//   return users;
// });

// class _ViewStudentsScreenState extends State<ViewStudentsScreen> {
//   List<Student> employees = <Student>[];
//   late EmployeeDataSource employeeDataSource;
//   @override
//   void initState() {
//     super.initState();
//     employees = [];
//     employeeDataSource = EmployeeDataSource(employeeData: employees);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: SizedBox(
//           height: 150,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               FloatingActionButton(
//                 tooltip: 'Add a class',
//                 child: const Icon(Icons.school_outlined),
//                 onPressed: () {},
//               ),
//               FloatingActionButton(
//                 tooltip: 'Add a student',
//                 child: const Icon(Icons.add_reaction),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const ListTile(
//                   leading: Text('All Classes'),
//                 ),
//                 Wrap(
//                   alignment: WrapAlignment.start,
//                   runAlignment: WrapAlignment.start,
//                   children: List.generate(
//                       3,
//                       (index) => const SizedBox(
//                             height: 70,
//                             width: 150,
//                             child: Card(
//                               color: Colors.red,
//                             ),
//                           )),
//                 )
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   ListTile(
//                       leading: const Text('All Students'),
//                       trailing: TextField(
//                         decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: const Icon(Icons.search),
//                                 onPressed: () {})),
//                       )),
//                   Expanded(
//                     child: SfDataGrid(
//                       source: employeeDataSource,
//                       columnWidthMode: ColumnWidthMode.fill,
//                       columns: <GridColumn>[
//                         GridColumn(
//                             columnName: 'id',
//                             label: Container(
//                                 padding: const EdgeInsets.all(16.0),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   'ID',
//                                 ))),
//                         GridColumn(
//                             columnName: 'photo',
//                             label: Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: const Text('Photo'))),
//                         GridColumn(
//                             columnName: 'name',
//                             label: Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: const Text('Name'))),
//                         GridColumn(
//                             columnName: 'class',
//                             label: Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   'Class',
//                                   overflow: TextOverflow.ellipsis,
//                                 ))),
//                         GridColumn(
//                             columnName: 'gender',
//                             label: Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   'Gender',
//                                   overflow: TextOverflow.ellipsis,
//                                 ))),
//                         GridColumn(
//                             columnName: 'Class',
//                             label: Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   'Address',
//                                   overflow: TextOverflow.ellipsis,
//                                 ))),
//                         GridColumn(
//                             columnName: 'age',
//                             label: Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: const Text('Age'))),
//                         GridColumn(
//                             columnName: 'dob',
//                             label: Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: const Text('Date Of Birth'))),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
