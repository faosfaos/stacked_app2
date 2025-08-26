extension StringValidation on String? {
  String? validateNullOrNotEmpty([String message = "Bu alan boş olamaz"]) {
    return (this == null || this!.isEmpty) ? message : null;
  }
}
