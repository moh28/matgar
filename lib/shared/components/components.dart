import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../cubit/cubit_shop_layout/shop_layout_cubit.dart';
import '../styles/colors.dart';
void navigateTo(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}
void navigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => Widget), (route) => false);
}
Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType? type,
  //Add question mark
  required String? Function(String? value) validate,
  required String? label,
  required IconData? prefix,
  bool isPassword = false,
  final IconData? suf,
  final VoidCallback? onSufPress,
  final Function(String?value)?onSubmit,
  GestureTapCallback? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      validator: validate,
      decoration: InputDecoration(
          suffixIcon: suf != null
              ? IconButton(
              onPressed: onSufPress,
              icon: Icon(suf))
              : null,
          labelText: label,
          prefixIcon: Icon(prefix),
          border: const OutlineInputBorder()),
    );
Widget defaultButton({
  required String text,
  required void Function()? onPress,
  double width = double.infinity,
  Color background = defaultColor,
  double hieght = 40.0,
  double radius = 5.0,
}) =>
    Container(
      height: hieght,
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
          onPressed:onPress ,
          child: Text(text.toUpperCase())),
    );
Widget defaultTextButton({required void Function()? onPress,required String text})=>
    TextButton(onPressed: onPress, child: Text(text.toUpperCase()));
void showToast({required String text,required ToastStates state})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chosseToastColor(state),
    textColor: HexColor('333739'),
    fontSize: 16.0
);
enum ToastStates{SUCCESS,ERROR,WARNING}
Color? chosseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;

    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;

}
Widget buildListProduct( model,context,{bool isOldPrice=true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    width: double.infinity,
    child: Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,

            ),
            if (model.discount != 0 && isOldPrice)
              Container(

                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: defaultColor,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(height: 1.3, fontSize: 14.0),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: const TextStyle(
                        fontSize: 12.0, color: defaultColor),
                  ),
                  const SizedBox(
                    width: 7.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                      //print(model.id);
                    },
                    icon:  CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit
                          .get(context)
                          .favorites[model.id] == null || ShopCubit
                          .get(context)
                          .favorites[model.id] ==
                          true ? defaultColor : Colors
                          .grey,
                      child: const Icon(
                        Icons.favorite_border,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),

                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);