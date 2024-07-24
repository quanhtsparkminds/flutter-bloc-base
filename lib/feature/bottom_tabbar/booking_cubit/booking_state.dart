part of 'booking_cubit.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState.initial() = _BookingState;

  const factory BookingState.processing() = ProcessingState;

  const factory BookingState.endProcess() = EndProcessingState;

  const factory BookingState.neutral() = NeutralState;
}
