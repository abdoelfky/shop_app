import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_states.dart';
import 'package:shop_app/modules/login/loginscreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userData;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopUpdateLoadingState)LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormFeild(
                      validatorText: 'Name must be not empty',
                      controller: nameController,
                      inputType: TextInputType.text,
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormFeild(
                      validatorText: 'Email must be not empty',
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormFeild(
                      validatorText: 'Phone must be not empty',
                      controller: phoneController,
                      inputType: TextInputType.text,
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_iphone_outlined),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        string: 'UPDATE',
                        function: ()
                        {
                          if(formKey.currentState.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text);
                          }

                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        string: 'LogOut',
                        function: () {
                          CacheHelper.removeData(key:'token').then((value) {
                            if (value==true) {
                              navigateAndEnd(context, LoginScreen());
                              print('tokennnnnnnnnnn : $token');
                            }
                          }).catchError((error) {
                            print(error);
                          });
                        })
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => CircularProgressIndicator(),
        );
      },
    );
  }
}
