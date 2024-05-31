import 'package:example/option_model.dart';
import 'package:flutter/material.dart';
import 'package:my_select/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Example Demo'),
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MySelectController<OptionModel> sampleWithForm =
      MySelectController<OptionModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "MyDropDown With Form Validation",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MySelect<OptionModel>(
                    controller: sampleWithForm,
                    label: "MyDropDown With Form Validation",
                    backgroundColor: Colors.white,
                    items: OptionModel.dummyData,
                    itemBuilder: (item, isSelected) =>
                        MySelect.defauldItemBuilder(
                            label: item.title ?? "",
                            context: context,
                            isSelected: isSelected),
                    selectedBuilder: (selected) =>
                        MySelect.defaultSelectedBuilder(
                      label: selected.title ?? "",
                      context: context,
                    ),
                    validator: (selected) {
                      if (selected.isEmpty) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    toStringBuilder: (items) {
                      return items.map((e) => e.title ?? "").toList();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState?.validate();
                    },
                    child: const Text(
                      'Validate',
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
