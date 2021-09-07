import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workos/ui/widgets.dart';

import '../../colors.dart';

class ForgotPassword extends StatelessWidget {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: primaryColor,
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: 'E-mail',
                          hintStyle: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildButton("Fogot", primaryColor, () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
