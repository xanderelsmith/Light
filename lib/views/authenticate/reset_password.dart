import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../db_handler/db_services/api_services.dart';
import '../../db_handler/styles.dart';

class ResetPassword extends HookConsumerWidget {
  static String id = 'ResetPassword';
  const ResetPassword({Key? key}) : super(key: key);
  static final emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Reset password',
            style: Styles.text.copyWith(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_outlined,
              color: Colors.black,
            ),
          )),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: double.maxFinite,
              color: Styles.primaryThemeColor,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'images/recoverpassword.png',
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'images/recoverpassword2.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text(
                      'Don\'t worry!',
                      style: Styles.text
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                  Text(
                    'Just enter your email address  associated\n with your account',
                    textAlign: TextAlign.center,
                    style: Styles.text
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'We\'ll send you a verification code to reset your password',
                      textAlign: TextAlign.center,
                      style: Styles.text
                          .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: screensize.width / 1.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: emailcontroller,
                            onChanged: (text) {},
                            // controller: ,
                            decoration: InputDecoration(
                                //  errorText: _errorText(textfieldController),
                                labelText: 'input email address',
                                suffixIcon: const Icon(Icons.border_color),
                                //     : const Icon(Icons.border_color),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(screensize.width / 2.3, 50)),
                      onPressed: () async {
                        await ApiService.dopasswordReset(
                            useremail: emailcontroller.text.trim());
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                  title: Text(
                                      'Check your Mail for a reset link from Spark Software Inc '),
                                  content: Text(
                                      'Change your password and Log in again'),
                                ));
                      },
                      child: const Text('Send'),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
