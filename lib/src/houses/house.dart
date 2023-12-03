/// A house class that represents an entity.
class House {
  House(this.name, this.floors);

  int? id;

  final String name;

  final int floors;

  // Convert a House into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'floors': floors,
    };
  }
}
