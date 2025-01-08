import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:peefo/app_router.dart';
import 'package:peefo/data/repositories.dart';
import 'package:peefo/domain/repositories.dart';
import 'package:peefo/domain/repositories/order_item_repository.dart';
import 'package:peefo/domain/repositories/order_repository.dart';
import 'package:peefo/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/cart_local_datasource.dart';
import 'data/repositories/order_item_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'domain/repositories/cart_repository.dart';
import 'presentation/blocs/blocs.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'presentation/blocs/order/order_bloc.dart';
import 'presentation/cubits/cart_count_cubit.dart';

final sl = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  setupServiceLocator();
  runApp(MyApp(preferences: prefs));
}

void setupServiceLocator() async {
  // Repositories
  sl.registerLazySingleton<CartLocalDatasource>(
      () => CartLocalDatasource(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());

  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());

  sl.registerLazySingleton<OrderItemRepository>(
      () => OrderItemRepositoryImpl(sl<CartLocalDatasource>()));

  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(sl<CartLocalDatasource>()));

  sl.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  // Blocs
  sl.registerFactory(() => AuthenticationBloc(authenticationRepository: sl()));
  sl.registerFactory(() => ProductBloc(productRepository: sl()));
  sl.registerFactory(() => ProductBannerBloc(productRepository: sl()));
  sl.registerFactory(() => ProductDetailBloc(productRepository: sl()));
  sl.registerFactory(() => CartBloc(cartRepository: sl()));
  sl.registerFactory(() => AddToCartBloc(cartRepository: sl()));
  sl.registerFactory(() => UpdateCartItemBloc(cartRepository: sl()));
  sl.registerFactory(
      () => AddOrderBloc(orderRepository: sl(), orderItemRepository: sl()));
  sl.registerFactory(
      () => GetOrdersByUserBloc(orderRepository: sl<OrderRepository>()));
  // Cubits
  sl.registerFactory(() => CartCountCubit(cartRepository: sl()));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (_) => sl<AuthenticationRepository>()),
        RepositoryProvider<ProductRepository>(
            create: (_) => sl<ProductRepository>()),
        RepositoryProvider<CartRepository>(create: (_) => sl<CartRepository>()),
        RepositoryProvider<OrderRepository>(
            create: (_) => sl<OrderRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => InternetBloc()),
          BlocProvider(
            create: (context) => ThemeBloc(preferences: preferences),
          ),
          BlocProvider(
            create: (context) => sl<AuthenticationBloc>()..add(StartAuthen()),
          ),
          BlocProvider(
            create: (context) => sl<ProductBloc>()..add(FetchProduct()),
          ),
          BlocProvider(
            create: (context) => ProductBannerBloc(productRepository: sl()),
          ),
          BlocProvider(
            create: (context) => ProductDetailBloc(productRepository: sl()),
          ),
          BlocProvider(
            create: (context) => CartBloc(cartRepository: sl()),
          ),
          BlocProvider(
              create: (context) => AddToCartBloc(cartRepository: sl())),
          BlocProvider(
              create: (context) => UpdateCartItemBloc(cartRepository: sl())),
          // Cubits
          BlocProvider(
            create: (context) => CartCountCubit(cartRepository: sl()),
          ),
          BlocProvider(
            create: (context) =>
                AddOrderBloc(orderRepository: sl(), orderItemRepository: sl()),
          ),
          BlocProvider(
            create: (context) =>
                GetOrdersByUserBloc(orderRepository: sl<OrderRepository>()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return GetMaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Peepo',
              theme: state.themeData,
              getPages: AppRouter.routes,
              initialRoute: '/login',
            );
          },
        ),
      ),
    );
  }
}
