import 'package:car_tracking/features/auth/business_logic/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../presentation/widgets/CustomBtn.dart';
import '../../business_logic/auth_states.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final emailcontroller = TextEditingController();
    final passcontroller = TextEditingController();
    //bool _isLoading = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الشعار
                  Image.asset(
                    'assets/images/TOQ Logo2.png', // تأكد من إضافة الشعار في المجلد المناسب
                    height: 100,
                    width: 150, // يمكنك ضبط الحجم حسب الحاجة
                  ),
                  SizedBox(height: 40), // مسافة بين الشعار وحقول النص
                  // حقول النص
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: emailcontroller,
                            //    obscureText: !_isPasswordVisible, // Toggles password visibility
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              //   labelText: "رقم الحوال ", // Label in Arabic
                              hintText: "البريد الالكتروني ",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6C6C89)), // Lock icon

                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: Colors.grey,
                              ),

                              //Image.asset("assets/images/call.png"),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color:
                                      Colors.grey, // Border color when focused
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color: Colors.black38, // Default border color
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // مسافة بين الحقول
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: passcontroller,
                            obscureText: false, // Toggles password visibility
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              //     labelText: "كلمة المرور", // Label in Arabic
                              prefixIcon: Icon(Icons.lock),
                              hintText: "كلمة المرور", // Lock icon
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey), // Lock icon

                              // suffixIcon: IconButton(
                              //   icon: Icon(
                              //     !_isPasswordVisible ? Icons.visibility : Icons.visibility_off_rounded,
                              //   ),
                              //   onPressed: () {
                              //     setState(() {
                              //       _isPasswordVisible = !_isPasswordVisible;
                              //     });
                              //   },
                              // ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color:
                                      Colors.grey, // Border color when focused
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color: Colors.black38, // Default border color
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // مسافة بين الحقول

                        // CustomButton(
                        //   backGroundColor: const Color(0xff167AD8),
                        //   child:
                        //   // _isLoading
                        //   //     ? CircularProgressIndicator(
                        //   //         color: Colors.white) // إظهار اللودينج
                        //   //     :
                        //   Text("تسجيل الدخول",
                        //           style: TextStyle(
                        //               color: Colors.white, fontSize: 18)),
                        //   onPressed:
                        //   // _isLoading
                        //   //     ? null // تعطيل الزر أثناء التحميل
                        //   //     :
                        //       () async {
                        //           // setState(() {
                        //           //   _isLoading =
                        //           //       true; // تعطيل الزر وتفعيل اللودينج
                        //           // });
                        //
                        //           context.read<AuthCubit>().login(
                        //                 emailcontroller.text,
                        //                 passcontroller.text,
                        //               );
                        //         },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
