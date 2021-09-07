import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workos/colors.dart';
import 'package:workos/logic/auth_logic/cubit/auth_cubit.dart';
import 'package:workos/ui/auth/login_screen.dart';
import 'package:workos/ui/widgets.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var positionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var isShown = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animation) {
            if (animation == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            alignment: FractionalOffset(_animation.value, 0),
            imageUrl:
                'https://i1.wp.com/zeeoii.com/wp-content/uploads/2020/08/Mobile-Full-HD-AMOLED-Wallpaper-1080X1920-8.jpg?fit=768%2C1365&ssl=1',
            placeholder: (context, url) => Image.asset(
              'assets/images/wallpaper.jpg',
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLoginBanner(size),
                    _buildTExtFormsFields(),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var auth = AuthCubit.get(context);
                        return buildButton("SIGN UP", primaryColor, () {
                          if (formKey.currentState!.validate()) {
                            auth.signUpUsingEmailAndPassword(
                                email: emailController.text,
                                password: passController.text,
                                fullName: fullNameController.text,
                                position: positionController.text,
                                phone: phoneController.text,
                                context: context);
                          } else {
                            print('no');
                          }
                        });
                      },
                    ),

                    //Spacer(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        buildText("Already have an Account?", Colors.white, 17,
                            FontWeight.normal),
                        InkWell(
                          onTap: () {
                            naviagteToAndReplace(context, LoginScreen());
                          },
                          child: buildText(
                              "  LOGIN IN", primaryColor, 18, FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildLoginBanner(size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.12,
        ),
        buildText("SIGN UP", primaryColor, 40, FontWeight.bold),
        SizedBox(
          height: 7,
        ),
        buildText("Sign up to Connect with your Team Work", Colors.white, 16,
            FontWeight.bold),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }

  _buildTExtFormsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: TextFormField(
              validator: (value) {
                if (value!.length < 6) {
                  return "Can't be Empty";
                } else {
                  return null;
                }
              },
              controller: phoneController,
              cursorColor: primaryColor,
              style: GoogleFonts.quicksand(
                fontSize: 20,
                color: Colors.black,
              ),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: 'Phone',
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: TextFormField(
              validator: (value) {
                if (value!.length < 6) {
                  return "Can't be Empty";
                } else {
                  return null;
                }
              },
              controller: fullNameController,
              cursorColor: primaryColor,
              style: GoogleFonts.quicksand(
                fontSize: 20,
                color: Colors.black,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: 'Full Name',
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return "Can't be Empty";
                } else {
                  return null;
                }
              },
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: TextFormField(
              validator: (value) {
                if (value!.length < 6) {
                  return "Can't be Empty";
                } else {
                  return null;
                }
              },
              controller: passController,
              cursorColor: primaryColor,
              obscureText: isShown ? false : true,
              style: GoogleFonts.quicksand(
                fontSize: 20,
                color: Colors.black,
              ),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                    child:
                        Icon(isShown ? Icons.visibility_off : Icons.visibility),
                    onTap: () {
                      setState(() {
                        isShown = !isShown;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  hintText: 'Password',
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: TextFormField(
              validator: (value) {
                if (value!.length < 2) {
                  return "Can't be Empty";
                } else {
                  return null;
                }
              },
              controller: positionController,
              cursorColor: primaryColor,
              style: GoogleFonts.quicksand(
                fontSize: 20,
                color: Colors.black,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: 'Position',
                  hintStyle: GoogleFonts.quicksand(
                    fontSize: 20,
                    color: Colors.grey,
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
