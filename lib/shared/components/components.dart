import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/modules/login/loginscreen.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

void navigateAndEnd(context,widget)=>
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context)=>widget,),
        result: (Route<dynamic> route)=>false,

    );


void navigateTo(context, widget) => Navigator.push(

  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

Widget defaultButton({
  double width = 200,
  double height = 50.0,
  Color color,
  @required String string,
  @required Function function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(50)
      ),
      child: Center(
        child: MaterialButton(
            minWidth: width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(string.toUpperCase(),
                  style: TextStyle(fontSize: 18.2, fontWeight: FontWeight.bold,color: Colors.white)),
            ),
            onPressed: function),
      ),
    );

Widget defaultButton2({
  double width = 200,
  double height = 50.0,
  Color color,
  @required String string,
  @required Function function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50)
      ),
      child: Center(
        child: MaterialButton(
            minWidth: width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(string.toUpperCase(),
                  style: TextStyle(fontSize: 18.2, fontWeight: FontWeight.bold,color: Colors.blue)),
            ),
            onPressed: function),
      ),
    );





Widget defaultFormFeild({
  @required String validatorText,
  @required var controller,
  @required var inputType,
  IconData suffixIcon ,
  Function suffixPressed,
  @required Icon prefixIcon ,
  @required String labelText,
  bool isObsecured=false,
  Function onTap,




})=>TextFormField(
  onChanged: onTap,
  validator: (value){
    if(value.isEmpty)
    {return validatorText;}
    return null;
  },
  controller: controller,
  keyboardType: inputType,
  obscureText: isObsecured,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.0),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2.0,
      ),
    ),
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon != null
        ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffixIcon,
      ),
    )
        : null,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),

  ),
);

Widget signOut(context){CacheHelper.removeData(key:'token').then((value){
  if(value)
  {
    navigateAndEnd(context, LoginScreen());
  }
});
}

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[200],
  ),
);

Widget myToaster({@ required String message}){

  Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: Colors.green,
  textColor: Colors.black,
  fontSize: 16.0,
);
}

Widget defaultAppBar(
{
  @required BuildContext context,
  String title,
  List <Widget> actions
})=>AppBar(
  titleSpacing: 5.0,
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  title: Text(title),
  actions: actions,

  );
