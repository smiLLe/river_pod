library framework;

import 'dart:async';
import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import 'framework/select.dart';
import 'provider.dart';

part 'framework/auto_dispose.dart';
part 'framework/base_provider.dart';
part 'framework/container.dart';
part 'framework/family.dart';
part 'framework/scoped_provider.dart';
part 'framework/value_provider.dart';
part 'framework.freezed.dart';

@freezed
abstract class SubscriptionType with _$SubscriptionType {
  factory SubscriptionType.watch(ProviderElement element) = _Watch;
  factory SubscriptionType.listen(ProviderElement element) = _Listen;
}
