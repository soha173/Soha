// lib/cubits/search_filter_cubit/search_filter_state.dart

import 'package:flutter/foundation.dart'; // لـ @immutable
import '../../../data/doctor_model.dart';

@immutable
abstract class SearchFilterState {
  const SearchFilterState();
}

class SearchFilterInitial extends SearchFilterState {
  const SearchFilterInitial();
}

class SearchFilterLoading extends SearchFilterState {
  const SearchFilterLoading();
}

class SearchFilterLoaded extends SearchFilterState {
  final List<Doctor> doctors;

  const SearchFilterLoaded(this.doctors);
}

class SearchFilterError extends SearchFilterState {
  final String message;

  const SearchFilterError(this.message);
}
