import 'package:all_pay/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

import '../../../application/app_cubit/app_cubit.dart';
import '../../style/style.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, s) => p.selected != s.selected,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: ProsteIndexedStack(
              index: state.selected,
              children: [
                IndexedStackChild(child: const HomePage()),
                IndexedStackChild(child: const Placeholder()),
                IndexedStackChild(child: const Placeholder()),
                IndexedStackChild(child: const Placeholder()),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Style.primaryColor,
              unselectedItemColor: Theme.of(context).secondaryHeaderColor,
              backgroundColor: Theme.of(context).primaryColor,
              currentIndex: state.selected,
              onTap: (s) {
                context.read<AppCubit>().changePage(s);
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sync_alt), label: "MyCard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          ),
        );
      },
    );
  }
}
