import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_states.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state)
        {
          if(state is ChangeFavoritesSuccessState)
          {
            if(!state.model.status)
            {
              Fluttertoast.showToast(
                  msg: state.model.message,
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
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriesModel!=null,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                )),
            SizedBox(
              height: 10.0,
            ),
            Padding(
                padding: const EdgeInsets.all(15)
            ,child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),

                Container(
                  height: 100.0,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder:  (context,index)=> buildCategoriesItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(
                        width: 7.0,
                      ),
                      itemCount:categoriesModel.data.data.length),
                ),
                SizedBox(
                  height: 10.0,
                ),

                Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                ),
              ],
            ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                childAspectRatio: 1 / 1.58,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(model.data.products.length,
                    (index) => buildProduct(model.data.products[index],context)),
              ),
            )
          ],
        ),
      );
}

Widget buildProduct(ProductModel model,context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart, children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: double.infinity,
            height: 200.0,
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
        Padding(
          padding: const EdgeInsets.all(12.0),
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
                    '${model.price.round()} LE',
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
                      '${model.oldPrice.round()} LE',
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
                        backgroundColor: ShopCubit.get(context).favorites[model.id]?Colors.purple :Colors.grey ,
                          child: Icon(Icons.favorite_border,color: Colors.white,)),
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                      }
                      )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildCategoriesItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
