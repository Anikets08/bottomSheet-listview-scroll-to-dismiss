import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Sheet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Custom Bottom Sheet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool condition = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Testing Custom Bottom Sheet Implementation',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const MyBottomSheet(),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  bool _disableScroll = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text('Bottom Sheet'),
          const SizedBox(height: 50),
          Expanded(
            // we cannot use gesture detector because it won't work with listview
            // so we use listener
            child: Listener(
              onPointerMove: (event) {
                if (event.delta.dy < 0) {
                  setState(() {
                    _disableScroll = false;
                  });
                } else {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.minScrollExtent) {
                    setState(() {
                      _disableScroll = true;
                    });
                  }
                }
              },
              child: ListView.builder(
                itemCount: 200,
                controller: _scrollController,
                shrinkWrap: true,
                physics:
                    _disableScroll ? const NeverScrollableScrollPhysics() : null,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Item $index'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
