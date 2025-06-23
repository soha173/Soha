import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/colors-manager.dart';
import '../../data/user_model.dart';
import '../../logic/sign-up/cubit.dart';
import '../../logic/sign-up/state.dart';
import 'home_screen.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController confirmationController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Your Account Was Created Successfully")));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.em)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        color: ColorsManager.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                      style: TextStyle(
                        color: ColorsManager.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                    //name
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.fillColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: ColorsManager.borderColor, width: 1)),
                        hintText: "Name",
                        hintStyle: TextStyle(
                          color: ColorsManager.hintColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    //email
                    TextFormField(

                      controller: emailController,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.fillColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: ColorsManager.borderColor, width: 1)),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: ColorsManager.hintColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    //phone
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.fillColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: ColorsManager.borderColor, width: 1)),
                        hintText: "Phone",
                        hintStyle: TextStyle(
                          color: ColorsManager.hintColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    //gender
                    TextFormField(
                      controller: genderController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.fillColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: ColorsManager.borderColor, width: 1)),
                        hintText: "Gender",
                        hintStyle: TextStyle(
                          color: ColorsManager.hintColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    //password
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.fillColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: ColorsManager.borderColor, width: 1)),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: ColorsManager.hintColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),
                    //confirm password

                    TextFormField(
                      obscureText: true,
                      controller: confirmationController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.fillColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: ColorsManager.borderColor, width: 1)),
                        hintText: "Confirm password",
                        hintStyle: TextStyle(
                          color: ColorsManager.hintColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12),

                    //create button
                    InkWell(
                      onTap: () {
                        context.read<SignUpCubit>().signUp(UserModel(
                            name: nameController.text,
                            pass: passController.text,
                            confirmationPass: confirmationController.text,
                            gender: genderController.text,
                            email: emailController.text,
                            phone: phoneController.text
                        ));
                      },
                      child: Container(
                        width: 400,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorsManager.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}