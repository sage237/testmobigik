import 'package:flutter/material.dart';

class GridPage extends StatefulWidget {
  const GridPage(
      {super.key,
      required this.columns,
      required this.items,
      required this.rows});
  final int rows;
  final int columns;
  final String items;

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  late int rows;
  late int columns;
  late String items;
  Set<int> highlightedIndex = {};
  final search = TextEditingController();

  @override
  void initState() {
    rows = widget.rows;
    columns = widget.columns;
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: search,
                    onChanged: (val) {
                      setState(() {
                        search.text = val.toUpperCase();
                        highlightedIndex.clear();
                      });
                    },
                    decoration: InputDecoration(hintText: 'Enter Search Text'),
                  ),
                ),
                MaterialButton(
                  onPressed: searchOnGrid,
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rows),
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: highlightedIndex.contains(index)
                          ? Colors.green
                          : Colors.white),
                  child: Center(child: Text(items[index])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchOnGrid() {
    FocusManager.instance.primaryFocus!.unfocus();
    String searchString = search.text;
//Search Horizontally
    try {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j <= columns - searchString.length; j++) {
          String horizontalWord = items.substring(
              i * columns + j, i * columns + j + searchString.length);
          if (horizontalWord == searchString) {
            print('Found');
            for (int val = i * columns + j;
                val < i * columns + j + searchString.length;
                val++) {
              highlightedIndex.add(val);
            }
          }
        }
      }
    } catch (e) {
      print('h $e');
    }

    //Search Vertically
    try {
      for (int i = 0; i < columns; i++) {
        for (int j = 0; j <= rows - searchString.length; j++) {
          String verticalWord = '';
          List<int> vertInts = [];
          for (int k = 0; k < searchString.length; k++) {
            verticalWord += items[(j + k) * columns + i];
            vertInts.add((j + k) * columns + i);
          }
          if (verticalWord == searchString) {
            highlightedIndex.addAll(vertInts);
          }
        }
      }
    } catch (e) {}

    //Search Diagonally Upwards
    try {
      for (int i = searchString.length - 1; i < rows; i++) {
        for (int j = 0; j <= columns - searchString.length; j++) {
          String diagonalWord = '';
          List<int> diagInts = [];
          for (int k = 0; k < searchString.length; k++) {
            diagonalWord += items[(i - k) * columns + j + k];
            diagInts.add((i - k) * columns + j + k);
          }
          if (diagonalWord == searchString) {
            highlightedIndex.addAll(diagInts);
          }
        }
      }
    } catch (e) {
      print('d $e');
    }

    // Search diagonally downwards
       try {
      for (int i = 0; i <= rows - searchString.length; i++) {
        for (int j = 0; j <= columns - searchString.length; j++) {
          String diagonalWord = '';List<int> diagInts = [];
          for (int k = 0; k < searchString.length; k++) {
            diagonalWord += items[(i + k) * columns + j + k];
            diagInts.add((i + k) * columns + j + k);
          }
          if (diagonalWord == searchString) {
            highlightedIndex.addAll(diagInts);
          }
        }
      }
    }catch(e){
      print('EDD $e');
       }
    setState(() {});
  }
}
