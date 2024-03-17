import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'app_bloc.dart';
import 'core/di/service_locator.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const gray = Color(0xFFBDBDBD);
  late AppBloc _bloc;

  @override
  void initState() {
    _bloc = GetIt.I<AppBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorMain = Theme.of(context).colorScheme.inversePrimary;
    return BlocBuilder<AppBloc, AppState>(
      bloc: _bloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: colorMain,
              title: Text(widget.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text(
                    'Set valid API base URL in order to continue',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.compare_arrows,
                        color: Color(0xFF828282),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            errorText: state.urlError.trim().isEmpty
                                ? null
                                : state.urlError,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            hintText: 'Set url...',
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1,
                                color: Color(0xFF333333)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: gray,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFEB5757),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: gray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: gray,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: gray,
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            _bloc.add(CheckIsValidUrlEvent(url: text));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: state.isActiveButton ? colorMain : const Color(0xFFBDBDBD),
              onPressed: state.isActiveButton ? () {} : null,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  'Start counting process',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      },
    );
  }
}
