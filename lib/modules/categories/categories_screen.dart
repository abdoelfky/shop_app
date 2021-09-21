import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
       builder:(context,state){
        return    ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index] ),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel.data.data.length
        );

       }


    );
  }
}

Widget buildCatItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage(model.image),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      SizedBox(height: 10,
        width: 15,),
      Text(
        model.name,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios),
    ],
  ),
);
