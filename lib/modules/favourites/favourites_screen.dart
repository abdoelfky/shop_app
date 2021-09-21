import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){},
        builder:(context,state){
          return    ConditionalBuilder(
            condition: state is !GetShopFavoritesLoadingState,
            builder:(context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildFavItem(ShopCubit.get(context).favoritesModel.data.data[index].product,context),
          separatorBuilder: (context,index)=>myDivider(),
          itemCount:ShopCubit.get(context).favoritesModel.data.data.length,
          ),
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,

          );

        }


    );
  }


  Widget buildFavItem(model,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 120.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0)
              Container(
                height: 14.0,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
          ]),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, height: 1.3, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round().toString()} LE',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round().toString()} LE',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        icon: CircleAvatar(
                            backgroundColor:
                            ShopCubit.get(context).favorites[model.id]
                                ? Colors.purple
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                          ShopCubit.get(context).getFavorites();

                          print(model.id);
                        })
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


