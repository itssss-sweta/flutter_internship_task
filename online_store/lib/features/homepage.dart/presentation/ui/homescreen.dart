import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/core/components/appbar.dart';
import 'package:online_store/core/components/bottomnavbar.dart';
import 'package:online_store/core/components/shimmereffect.dart';
import 'package:online_store/core/constants/colors.dart';
import 'package:online_store/core/constants/padding.dart';
import 'package:online_store/core/constants/textstyle.dart';
import 'package:online_store/features/homepage.dart/presentation/ui/components/categories.dart';
import 'package:online_store/features/homepage.dart/presentation/ui/components/productlist.dart';
import 'package:online_store/features/homepage.dart/presentation/cubit/home/home_cubit_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final homePageModel = context.read<HomeCubitCubit>();
    homePageModel.getProducts();
    homePageModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final homePageModel = context.read<HomeCubitCubit>();
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: const CustomAppBar(),
      ),
      body: BlocBuilder<HomeCubitCubit, HomeCubitState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const ShimmerLoadingWidget();
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.message ?? ''),
            );
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  'Categories',
                  style: lightStyle20,
                ),
                Container(
                    padding: all8padding,
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homePageModel.categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (state is LoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CategoryList(
                          category: homePageModel.categories![index],
                        );
                      },
                    )),
                Padding(
                  padding: smallsymmetric,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Browse Products', style: semiboldStyle20)),
                ),
                GridViewContainer(
                    latestproduct:
                        state is DataLoadedState ? state.homePageModel : null),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const NavBarBottom(),
    );
  }
}
