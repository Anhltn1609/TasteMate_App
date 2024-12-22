import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_bloc.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_event.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_state.dart';
import 'package:tastemate_app/feature/discovery/view/component/category_tab.dart';
import 'package:tastemate_app/feature/discovery/view/component/supplier_tab.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final discoveryBloc = context.read<DiscoveryBloc>();
    discoveryBloc.add(LoadCategoryEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).discovery,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppStyles.primaryColor,
          ),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.profile);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: Image.network(
                  ApiService.user.avatar ?? AppConfigs.fakeUrl,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person,
                        color: Colors.grey[700], size: 30);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: translation(context).products),
            Tab(text: translation(context).brands),
          ],
          indicatorColor: AppStyles.primaryColor,
          labelColor: Colors.black,
        ),
      ),
      body: BlocListener<DiscoveryBloc, DiscoveryState>(
        listener: (context, state) {
          if (state is DiscoveryFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
          builder: (context, state) {
            if (state is DiscoveryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DiscoveryFailure) {
              return Center(child: Text(state.message));
            } else {
              return TabBarView(
                controller: _tabController,
                children: const [
                  CategoryTab(),
                  SupplierTab(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
