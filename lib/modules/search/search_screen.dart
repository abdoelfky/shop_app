import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/search/search_cubit.dart';
import 'package:shop_app/modules/search/sreach_states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var searchController=TextEditingController();
    return BlocProvider(
        create: (BuildContext context)=>SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchStates>(
            listener:(context,state){} ,
          builder:(context,state)
          {
            return Scaffold(
              appBar:AppBar() ,
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      defaultFormFeild(
                          validatorText: 'please Enter Text To Search',
                          controller: searchController,
                          inputType: TextInputType.text,
                          prefixIcon: Icon(Icons.search),
                          labelText: 'SEARCH',
                        onTap: (String text)
                        {
                          SearchCubit.get(context).search(text: text);
                        }
                      ),
                      SizedBox(height: 15,),
                      if(state is SearchLoadingState)LinearProgressIndicator(),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index)=>buildSearchItem(SearchCubit.get(context).model.data.data[index],context),
                            separatorBuilder:(context,index)=> myDivider(),
                            itemCount:SearchCubit.get(context).model.data.data.length),
                      )
                    ],
                  ),
                ),
              ),
            );
          } ,

        ),


    );
  }

  Widget buildSearchItem(model,context)=> Padding(
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
