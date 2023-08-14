import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/main_cubit/main_cubit.dart';

Widget buildArticleItem(article,context){
  return InkWell(
    onTap: () {
      print('test that fucking shitttttttt');
      print('the ulr that you want to enter is : ${article['url']}');
      // Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(URL: '${article['url']}'),));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0,),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget defaultFormField (
    {
      required context,
      Function(String?)? onChanged,
      var onFieldSubmitted,
      required TextEditingController controller,
      bool obscureText=false,
      IconData? suffixIcon,
      // required String? Function(String?)? validate,
      required IconData? prefixIcon,
      required String labelText,
      required bool validation ,
      String? alertText='Field is required',
      var suffixClick,
      String? hitText,
      String? errorText,
      double width=double.infinity,
      TextInputType? keyBoardType,
      ScrollPhysics? scrollPhysics,
      FocusNode? brightWhenSubmit,
      var key,
      var onTapFunction,
    }

    ){
  return
    Container(
      width: width ,
      child: TextFormField(
        onTap: onTapFunction,
        key: key,
        focusNode: brightWhenSubmit,
        scrollPhysics: scrollPhysics,
        style: Theme.of(context).textTheme.bodyText1,

        onChanged: onChanged,
        keyboardType: keyBoardType,
        controller: controller,
        obscureText: obscureText,

        decoration: InputDecoration(
          hintText:hitText ,
          errorText: errorText,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:MainCubit.get(context).isDark?Colors.red:Colors.grey)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          prefixIcon: Icon(prefixIcon),
          labelText: labelText,
          suffixIcon: suffixIcon !=null ? IconButton(onPressed: suffixClick, icon: Icon(suffixIcon)):null,
        ),
        validator: (value){
          if (validation){

            if(value==null||value.isEmpty){
              return alertText;
            }
            return null;
          }
        },

        onFieldSubmitted: onFieldSubmitted,
      ),
    );
}


Widget defaultButton(
    {
      required String text,
      required Color buttonColor,
      double width = double.infinity,
      double height = 40.0,
      Color textColor = Colors.white,
      required Function() function,
      double fontSize=14,
    }
    ){
  return Container(
    width: width,
    child: MaterialButton(
      onPressed: function,
      color: buttonColor,
      height: height,
      child: Text(
        text,
        style: TextStyle(
          color:textColor,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget textbutton({
  required String text,
  required String? coloredText,
  Color coloredTextColor=Colors.blue,
  Color textColor=Colors.black,
  required Function() function,
  MainAxisAlignment mainAlignment=MainAxisAlignment.start,
}
    ){
  return Row(
    mainAxisAlignment: mainAlignment,
    children: [
      Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
      TextButton(onPressed: function, child: Text(
        '$coloredText',
        style: TextStyle(
          color: coloredTextColor,
        ),
      ))
    ],
  );
}

void navigateTo(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget,));
}

void navigateAndFinish(context,widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget,));
}
void navigateAndNeverComeBack(context,widget){
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
        builder: (context) => widget,), (
          route) => false);
}
void showToast({
  required String? msg,
  required Color color,
}){
  Fluttertoast.showToast(
      msg:msg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
