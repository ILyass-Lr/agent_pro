enum Status { pending, approved, suspended, rejected }

Status statusFromJson(String? value) {
  return Status.values.firstWhere(
    (e) => e.name.toLowerCase() == value?.toLowerCase(),
    orElse: () => Status.pending, // default to pending if unknown value
  );
}
