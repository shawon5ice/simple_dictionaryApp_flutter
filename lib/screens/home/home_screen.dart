import 'package:dictionary_using_bloc/bloc/dictionary_cubit.dart';
import 'package:dictionary_using_bloc/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  getDictionaryFromWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Center(
              child: Column(
                children: [
                  Text(
                    'Dictionary App',
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Search by word you want quickly',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: cubit.queryController,
                      cursorColor: Colors.orange.shade900,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          gapPadding: 0,
                        ),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.getWordSearched();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange.shade900,
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontWeight: FontWeight.normal),
              ),
              child: const Text(
                'SEARCH',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  getErrorWidget(message) {
    return Center(child: Text(message));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener(
      listener: (context, state) => {
        if (state is WordSearchedState && state.words != null)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListScreen(state.words),
              ),
            )
          }
      },
      bloc: cubit,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.blueGrey[900],
          body: cubit.state is WordSearchingState
              ? getLoadingWidget()
              : cubit.state is ErrorState
                  ? getErrorWidget("Something wrong happened")
                  : cubit.state is NoWordSearchedState
                      ? getDictionaryFromWidget(context)
                      : Container()),
    );
  }
}
