import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/enums/genderEnum.dart';
import 'package:light/models/students_data_model.dart';

import 'package:light/utils/deshtoptextfield.dart';
import '../../controller/addPatientController.dart';

final addstudentlistProvider =
    StateNotifierProvider<StudentsListNotifier, List<StudentsModel>>(
        (ref) => StudentsListNotifier());

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        appBar: PreferredSize(
            preferredSize: const Size(50, 50),
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              child: Row(
                children: [
                  const Text('Your plan duration'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.only(right: 200.0, left: 5),
                        margin: const EdgeInsets.all(8.0),
                        width: double.maxFinite,
                        child: const Divider(
                          color: Colors.amber,
                          thickness: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: Card(
                color: Colors.grey,
                child: Column(children: const [Text('howdy')]),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: Row(
                  children: List.generate(
                      2,
                      (index) => Expanded(
                              child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(index == 1
                                    ? 'Quiz materials'
                                    : 'Reviews from your parents'),
                                ...List.generate(
                                  3,
                                  (index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: const BoxDecoration(
                                          color: Colors.grey),
                                      child:
                                          const Text('We love your schools')),
                                )
                              ],
                            ),
                          )))),
            ),
          )
        ]));
  }
}
