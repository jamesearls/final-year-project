import 'package:flutter/material.dart';

import '../../models/models.dart';

class BuildingView extends StatelessWidget {
  final Building building;
  const BuildingView({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: building.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    BuildingScreen(building: building),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/${building.img}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    building.name,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildingScreen extends StatelessWidget {
  final Building building;
  const BuildingScreen({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(building.name),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: building.img,
          child: Image.asset('assets/images/${building.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Text(
          building.name,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
