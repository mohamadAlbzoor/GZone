class RoomInformation {
  final String id;
  final String ownerId;
  final String title;
  final String gameId;
  final int capacity;
  final int currentCount;

  RoomInformation({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.capacity,
    required this.currentCount,
    required this.gameId,
  });

  static RoomInformation fromJson(Map<String, dynamic> json) => RoomInformation(
      id: json['id'],
      ownerId: json['owner_id'],
      title: json['title'],
      gameId: json['game_id'],
      capacity: json['capacity'],
      currentCount: json['currentCount'],
  );
}
