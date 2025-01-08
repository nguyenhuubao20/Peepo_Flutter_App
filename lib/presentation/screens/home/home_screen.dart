import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/presentation/widgets/custom_app_bar.dart';

import '../../blocs/blocs.dart';
import 'components/product_banner.dart';
import 'components/product_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = [
    'Tất cả',
    'Túi xách',
    'Ba lô',
    'Túi đeo chéo',
    'Phụ kiện'
  ];

  int selectedCategory = 0;

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      context.read<ProductBloc>().add(FetchProduct());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        onSearchPressed: () {
          Navigator.pushNamed(context, '/search');
        },
        onCartPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData, // Hàm refresh khi người dùng kéo màn hình
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://t4.ftcdn.net/jpg/02/49/50/15/360_F_249501541_XmWdfAfUbWAvGxBwAM0ba2aYT36ntlpH.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Các sản phẩm mới nhất',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Banner Carousel
              ProductBanner(),

              // Categories
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Danh mục',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: selectedCategory == index
                              ? Colors.black87
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: selectedCategory == index
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Products Grid
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Sản phẩm nổi bật',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ProductGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
