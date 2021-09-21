import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/home_screen/home_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginSuccessState)
          {
            if (state.loginModel.status)
            {
              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).
              then((value)
              {token=state.loginModel.data.token;
                navigateAndEnd(context,HomeLayout());
              }).
              catchError((onError)
              {
                print(state.loginModel.message);
              });
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
              );
            }
            else
              {
                print(state.loginModel.message);

                Fluttertoast.showToast(
                    msg: state.loginModel.message,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
          }
        },
        builder:(context,state){
          return  Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0
                          ),),
                        SizedBox(height: 15.0,),
                        Text('login now to browse our hot offers ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                              color: Colors.grey
                          ),),
                        SizedBox(height: 15.0,),
                        defaultFormFeild(
                            validatorText: 'please enter your Email Address',
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email Address'
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormFeild(
                          validatorText: 'please enter your Password',
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          suffixPressed:()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          isObsecured: ShopLoginCubit.get(context).isPasswordShown,
                          labelText: 'Password',
                        ),
                        SizedBox(height: 20.0,),
                        ConditionalBuilder(
                          condition:state is! LoginLoadingState ,
                          builder:(context)=>defaultButton(
                              string: 'LOGIN',
                              function: (){
                                if(formKey.currentState.validate())
                                {print(emailController.text);
                                ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                                },
                              color: Colors.purpleAccent),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0,),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account ? ',
                              style: TextStyle(fontSize: 18.0
                                  ,fontWeight: FontWeight.bold),),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, RegisterScreen());
                              }                    ,
                              child:Text(
                                'REGISTER',
                                style: TextStyle(fontSize: 16.5
                                    ,fontWeight: FontWeight.bold),),
                            )
                          ],
                        )




                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
              ),
    );
  }
}
