import 'package:flutter/material.dart';
import 'package:scutum_test_assignment/src/houses/houses_service.dart';

import 'house.dart';
import '../floors/floors_list_page.dart';

/// Displays a list of Houses.
class HousesListPage extends StatefulWidget {
  const HousesListPage({
    super.key,
  });

  static const routeName = '/houses';

  @override
  State<HousesListPage> createState() => _HousesListPageState();
}

class _HousesListPageState extends State<HousesListPage> {
  final _housesService = HousesService();

  final _nameFieldController = TextEditingController();
  final _floorsFieldController = TextEditingController();

  List<House>? items;

  @override
  void initState() {
    _housesService.getHouses().then((value) => setState(() {
          items = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: ListView.builder(
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          restorationId: 'housesListView',
          itemCount: items == null ? 0 : items!.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              // return the header
              return OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(220, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(12)))),
                onPressed: () async {
                  await showDialog<void>(
                      context: context,
                      builder: (context) => AddHousePopup(
                            nameFieldController: _nameFieldController,
                            floorsFieldController: _floorsFieldController,
                            onPressed: () async {
                              var newHouse = House(
                                  _nameFieldController.text,
                                  int.tryParse(_floorsFieldController.text) ??
                                      0);

                              await _housesService.addHouse(newHouse);
                              setState(() {
                                items!.add(newHouse);
                              });
                            },
                          ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 3,),
                    Text(
                      'Add house',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    Spacer(),
                    Icon(
                      Icons.add,
                      size: 32,
                      color: Colors.black,
                    ),
                    Spacer(),
                  ],
                ),
              );
            }
            index -= 1;

            final item = items![index];

            return Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Center(
                    child:
                        Text(item.name, style: const TextStyle(fontSize: 16)),
                  ),
                  leading: const Text(
                    'House',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    // Navigate to the floors page. If the user leaves and returns to
                    // the app after it has been killed while running in the
                    // background, the navigation stack is restored.
                    Navigator.restorablePushNamed(
                      context,
                      FloorsListPage.routeName,
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}

class AddHousePopup extends StatelessWidget {
  const AddHousePopup({
    super.key,
    required TextEditingController nameFieldController,
    required TextEditingController floorsFieldController,
    required void Function() onPressed,
  })  : _nameFieldController = nameFieldController,
        _floorsFieldController = floorsFieldController,
        _onPressed = onPressed;

  final TextEditingController _nameFieldController;
  final TextEditingController _floorsFieldController;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40,
            top: -40,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _nameFieldController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _floorsFieldController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                    onPressed: () {
                      _onPressed();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add')),
              )
            ],
          ),
        ],
      ),
    );
  }
}
