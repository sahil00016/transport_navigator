import 'dart:math';
import '../models/route_model.dart';

class RouteService {
  // Mocked transit graph: nodes (stations) and edges (routes)
  final Map<String, Map<String, double>> _graph = {
    'StationA': {'StationB': 10, 'StationC': 15},
    'StationB': {'StationA': 10, 'StationD': 12},
    'StationC': {'StationA': 15, 'StationD': 10},
    'StationD': {'StationB': 12, 'StationC': 10},
  };

  RouteModel calculateOptimalRoute(double speedVsCost) {
    // Simplified Dijkstra's algorithm
    String start = 'StationA';
    String end = 'StationD';
    Map<String, double> distances = {start: 0};
    Map<String, String> previous = {};
    List<String> unvisited = _graph.keys.toList();

    while (unvisited.isNotEmpty) {
      String current = unvisited.reduce((a, b) =>
      (distances[a] ?? double.infinity) < (distances[b] ?? double.infinity)
          ? a
          : b);
      unvisited.remove(current);

      for (var neighbor in _graph[current]!.keys) {
        double weight = _graph[current]![neighbor]!;
        // Adjust weight based on speedVsCost (0 = cost, 1 = speed)
        double adjustedWeight = weight * (1 - speedVsCost * 0.5);
        double distance = (distances[current] ?? double.infinity) + adjustedWeight;

        if (distance < (distances[neighbor] ?? double.infinity)) {
          distances[neighbor] = distance;
          previous[neighbor] = current;
        }
      }
    }

    // Reconstruct path
    List<String> path = [];
    String? current = end;
    while (current != null) {
      path.add(current);
      current = previous[current];
    }
    path = path.reversed.toList();

    // Mocked route details
    double eta = distances[end]! * 2; // Mocked ETA in minutes
    double cost = distances[end]! * 0.5; // Mocked cost in dollars

    return RouteModel(
      id: Random().nextInt(1000000).toString(),
      description: 'Bus ${path[0]} → Metro ${path.last}',
      eta: eta,
      cost: cost,
      timestamp: DateTime.now(),
    );
  }
}