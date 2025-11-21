class FlyersController {
  List<String> flyers = [
    "https://via.placeholder.com/300x400",
    "https://via.placeholder.com/300x400",
    "https://via.placeholder.com/300x400",
    "https://via.placeholder.com/300x400",
  ];

  Future<List<String>> loadFlyers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return flyers;
  }
}
