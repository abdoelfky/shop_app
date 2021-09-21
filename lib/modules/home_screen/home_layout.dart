import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon:Icon(Icons.search),
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                ),
              )
            ],
          ),
          body:cubit.bottomsScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            onTap: (index)
            {
              cubit.changeBottom(index: index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),

            ],
          )
          ,
        );
      },
    );
  }
}
