import 'package:flutter/material.dart';

class ComponentsTab extends StatelessWidget {
  const ComponentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Material 3 Components",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "See how your active theme applies across standard UI elements.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          
          _Section("Buttons", children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Elevated")),
                FilledButton(onPressed: () {}, child: const Text("Filled")),
                FilledButton.tonal(onPressed: () {}, child: const Text("Tonal")),
                OutlinedButton(onPressed: () {}, child: const Text("Outlined")),
                TextButton(onPressed: () {}, child: const Text("Text")),
              ],
            ),
          ]),

          _Section("Floating Action Buttons", children: [
            Wrap(
              spacing: 16,
              children: [
                FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.add)),
                FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
                FloatingActionButton.extended(onPressed: () {}, icon: const Icon(Icons.add), label: const Text("Extended")),
              ],
            ),
          ]),

          _Section("Inputs & Selection", children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Standard Input",
                hintText: "Enter some text",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: "Filled Input",
                filled: true,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: "Outlined Input",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Checkbox(value: true, onChanged: (_) {}),
                RadioGroup<int>(
                  groupValue: 1,
                  onChanged: (_) {},
                  child: const Radio<int>(value: 1),
                ),
                Switch(value: true, onChanged: (_) {}),
              ],
            ),
            const SizedBox(height: 16),
            Slider(value: 0.5, onChanged: (_) {}),
          ]),

          _Section("Chips", children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                const Chip(label: Text("Standard Chip"), avatar: Icon(Icons.star, size: 16)),
                InputChip(label: const Text("Input Chip"), onSelected: (_) {}, selected: true),
                ActionChip(label: const Text("Action Chip"), onPressed: () {}, avatar: const Icon(Icons.touch_app, size: 16)),
              ],
            ),
          ]),

          _Section("Cards & Surfaces", children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.album),
                title: const Text("Elevated Card"),
                subtitle: const Text("Default card style"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: ListTile(
                leading: const Icon(Icons.my_library_music),
                title: const Text("Filled Card"),
                subtitle: const Text("Using surfaceContainerHighest"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.speaker),
                title: const Text("Outlined Card"),
                subtitle: const Text("Using outline color"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
          ]),
          
          _Section("Dialog & SnackBar", children: [
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Dialog Title"),
                        content: const Text("This is a standard Material 3 dialog. Observe how the theme affects it."),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                          FilledButton(onPressed: () => Navigator.pop(context), child: const Text("Confirm")),
                        ],
                      ),
                    );
                  },
                  child: const Text("Show Dialog"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("This is a SnackBar"),
                        action: SnackBarAction(label: "Undo", onPressed: () {}),
                      ),
                    );
                  },
                  child: const Text("Show SnackBar"),
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section(this.title, {required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
