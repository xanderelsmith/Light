import 'package:flutter/material.dart';

class HomePageThirdTab extends StatelessWidget {
  const HomePageThirdTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SizedBox(
            width: double.maxFinite,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Calender')]),
              ),
            ),
          )),
          Expanded(
              flex: 3,
              child: SizedBox(
                width: double.maxFinite,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('Calender')]),
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: SizedBox(
                width: double.maxFinite,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('Calender')]),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
