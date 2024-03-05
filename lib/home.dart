import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'grid_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  bool rowsAndColumn = false;
  final rowTcon = TextEditingController();
  final colTcon = TextEditingController();

  int totalItems = 0;

  final items = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  TextFormField(
                    controller: rowTcon,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration:
                        InputDecoration(hintText: 'Enter number of rows'),
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Required';
                      return null;
                    },
                    onChanged: (val) {
                      rowsAndColumn = false;
                      items.clear();
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: colTcon,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration:
                        InputDecoration(hintText: 'Enter number of columnns'),
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Required';
                      return null;
                    },
                    onChanged: (val) {
                      items.clear();
                      rowsAndColumn = false;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (rowsAndColumn)
                    TextFormField(
                      controller: items,
                      minLines: 3,
                      maxLines: 5,
                      maxLength: totalItems,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required';
                        }

                        if (val.length != totalItems)
                          return 'Invalid length of alphabets';

                        return null;
                      },
                      onChanged: (val) {
                        items.text = val.toUpperCase();
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter $totalItems alphabets',
                          hintText: 'Without Spaces'),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate())
                          rowsAndColumn = formKey.currentState!.validate();
                        int rows = int.parse(rowTcon.text);
                        int col = int.parse(colTcon.text);
                        totalItems = rows * col;

                        setState(() {});

                        if (items.text.length == totalItems)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GridPage(
                                        rows: rows,
                                        columns: col,
                                        items: items.text,
                                      )));
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
