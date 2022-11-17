import 'package:first_app/Layout/shop_app/cubit/shop_cubit.dart';
import 'package:first_app/Layout/shop_app/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! ShopLoadingGetFavoritesState
            ? ListView.separated(
                itemBuilder: (context, index) => buildListProduct(
                    ShopCubit.get(context)
                        .favoritesModel
                        .data!
                        .data![index]
                        .product,
                    context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount:
                    ShopCubit.get(context).favoritesModel.data!.data!.length,
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
