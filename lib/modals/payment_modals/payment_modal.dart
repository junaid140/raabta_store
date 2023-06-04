class PaymentModal {
  final String id;
  final String name;
  final String image;
  final int number;

  PaymentModal({
    required this.id,
    required this.name, required this.image, required this.number});

  factory PaymentModal.fromJson(Map<String, dynamic> json) {
    return PaymentModal(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'number': number,
    };
  }
}
