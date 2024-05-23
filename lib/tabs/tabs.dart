import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/calculator/calculator_screen.dart';
import 'package:uzb_currency/home/currencies_screen.dart';
import 'package:uzb_currency/tabs/cubit/tabs_cubit.dart';

// Main screen that handles navigation between different tabs
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((TabsCubit cubit) => cubit.pageIndex);
    String pageTitle = switch (selectedTab) {
      0 => "Rates",
      1 => "Calculator",
      _ => throw UnimplementedError(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<TabsCubit, TabsState>(
        buildWhen: (previous, current) {
          if (current is TabsPageChanged) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is TabsInitial) {
            return IndexedStack(
              index: selectedTab,
              children: const [
                CurrenciesScreen(),
                CalculatorScreen(),
              ],
            );
          } else if (state is TabsError) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            );
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: BlocProvider.of<TabsCubit>(context).selectPage,
        currentIndex: selectedTab,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange_outlined),
            label: "Rates",
            activeIcon: Icon(Icons.currency_exchange),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: "Calculator",
            activeIcon: Icon(Icons.calculate),
          ),
        ],
      ),
    );
  }
}
