import 'package:e_commerce_app/controller/manager/auth/verfiycode/cubit/verfiycode_cubit.dart';
import 'package:e_commerce_app/core/utils/approuter.dart';
import 'package:e_commerce_app/view/widgets/auth/customTextBodyAuth.dart';
import 'package:e_commerce_app/view/widgets/auth/customTetxTitleAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';



class VerfiycodeScreen extends StatelessWidget {
  const VerfiycodeScreen({super.key, required this.email});
  final String email;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VerfiycodeCubit(),
        child: BlocConsumer<VerfiycodeCubit, VerfiycodeState>(
          listener: (context, state) {
           if (state is VerfiycodeSuccessful ) {
  
  context.go(Approuter.KSuccessSignup);
} else if (state is VerfiycodeFailuer) {
              
              

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("please try agin"),
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Verify Code',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      CustomTextTitleAuth(titleText: 'Check Email'),
                      const SizedBox(height: 20),
                      CustomTextBodyAuth(
                        tetxBody: 'Please Enter The Digit Code Sent To $email',
                        
                      ),
                      const SizedBox(height: 40),
                    OtpTextField(
  numberOfFields: 5,
  borderColor: Color(0xFF512DA8),
  showFieldAsBox: true,
  onSubmit: (String verificationCode) {
    context.read<VerfiycodeCubit>().getVerfiyCode(verificationCode, email);
    if(state is VerfiycodeSuccessful){
      context.go(Approuter.KSuccessSignup);
    print("Email: $email, Code: $verificationCode");
    }
  },
),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
