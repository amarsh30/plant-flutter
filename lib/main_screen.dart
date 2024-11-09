import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant/detail_screen.dart';
import 'package:plant/model/ornamental_plant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Tanaman Hias',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth <= 600) {
                return PlantList();
              } else if (constraints.maxWidth <= 1200) {
                return PlantGrid(gridCount: 4);
              } else {
                return PlantGrid(gridCount: 6);
              }
            },
          ),
        );
      },
    );
  }
}

class PlantList extends StatelessWidget {
  const PlantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/garden.jpeg',
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final OrnamentalPlant plant = ornamentalPlantList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailScreen(plant: plant);
                    }));
                  },
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            plant.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plant.name,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(plant.nameIlmiah),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
              itemCount: ornamentalPlantList.length,
            ),
          ),
        ),
      ],
    );
  }
}

class PlantGrid extends StatelessWidget {
  final int gridCount;

  const PlantGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(
        crossAxisCount: gridCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: ornamentalPlantList.map((plant) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(plant: plant);
              }));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      plant.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      plant.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      plant.nameIlmiah,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
