import 'package:flutter/material.dart';

// 🌐 Veri Taşıyan Model
class Content {
  final String message;
  final Icon icon;
  Content({required this.message, required this.icon});
}

// 🧱 Temel Soyut Dialog Sınıfı
abstract class BaseDialog {
  Widget get title;
  set title(Widget value);

  Widget get content;
  set setContent(Content model);

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: title, content: content),
    );
  }
}

// 💡 Bilgi Dialogu
class InfoDialog extends BaseDialog {
  Widget? _title;
  Content? _model;

  @override
  Widget get title => _title ?? const Text("Bilgi");

  @override
  set title(Widget value) {
    _title = value;
  }

  @override
  Widget get content => Row(
    children: [
      _model?.icon ?? const Icon(Icons.info_outline),
      const SizedBox(width: 8),
      Expanded(child: Text(_model?.message ?? "Bilgi mesajı yok")),
    ],
  );

  @override
  set setContent(Content model) {
    if (model.message.length > 200) {
      throw Exception("Mesaj çok uzun!");
    }
    _model = model;
  }
}

// ⚠️ Uyarı Dialogu
class WarningDialog extends BaseDialog {
  Widget _title = const Text("Uyarı!");
  Content? _model;

  @override
  Widget get title => _title;

  @override
  set title(Widget value) {
    // Başlık sadece kırmızı olabilir kontrolü
    if (value is Text && (value.style?.color != Colors.red)) {
      debugPrint("Başlık Kırmızı olalıdır.");
    }
    _title = value;
  }

  @override
  Widget get content => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _model?.icon ?? const Icon(Icons.warning, color: Colors.amber),
      const SizedBox(height: 8),
      Text(
        _model?.message ?? "Uyarı mesajı yok",
        style: const TextStyle(color: Colors.red),
      ),
    ],
  );

  @override
  set setContent(Content model) {
    _model = model;
  }
}
