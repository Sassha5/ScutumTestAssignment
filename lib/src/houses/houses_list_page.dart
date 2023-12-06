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
                      barrierColor: Colors.transparent,
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
                    Spacer(
                      flex: 3,
                    ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(builder: (context) => FloorsListPage(house: item))
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
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: const Color.fromARGB(255, 210, 210, 210),
      shape: const ContinuousRectangleBorder(
        side: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                const Positioned(
                  top: 10,
                    left: 0,
                    right: 0,
                    child: Text(
                      'Add house',
                      textAlign: TextAlign.center,
                    )),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(child: Text('Name')),
              Expanded(
                  child: TextField(
                      controller: _nameFieldController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      ))),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(child: Text('Floors count')),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                          controller: _floorsFieldController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                          )),
                    ),
                    const SizedBox()
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 210, 210, 210),
                  minimumSize: const Size(120, 30),
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              onPressed: () {
                _onPressed();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          )
        ]),
      ),
    );
  }
}
