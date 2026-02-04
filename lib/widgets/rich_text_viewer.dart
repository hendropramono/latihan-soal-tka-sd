import 'package:flutter/material.dart';
import '../models/rich_text_content.dart'; // Sesuaikan path jika berbeda

class RichTextViewer extends StatelessWidget {
  final List<RichTextContent> content;
  final TextStyle defaultTextStyle;

  const RichTextViewer({
    super.key,
    required this.content,
    this.defaultTextStyle = const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
  });

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return const SizedBox.shrink(); // Tidak ada yang ditampilkan jika kosong
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.map((block) => _buildBlock(context, block)).toList(),
    );
  }

  Widget _buildBlock(BuildContext context, RichTextContent block) {
    if (block is TextData) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(block.text, style: defaultTextStyle),
      );
    }
    // Tambahkan case untuk tipe blok lain di sini jika model diperluas
    return const SizedBox.shrink();
  }
}
