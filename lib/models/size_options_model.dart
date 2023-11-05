class SizeOption {
  final String name, quantity;

  SizeOption({required this.name, required this.quantity});
}

List<SizeOption> sizeOptions = [
  SizeOption(name: 'Small', quantity: '350'),
  SizeOption(name: 'Medium', quantity: '450'),
  SizeOption(name: 'Large', quantity: '700'),
  // SizeOption(name: 'Custom', quantity: '...'),
];
