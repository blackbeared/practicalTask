import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/all.exports.dart';

extension FutureX<T> on Future<T> {
  Future<T> loading(BuildContext context, {bool cancelable = true}) {
    bool popByFuture = true;
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => cancelable,
          child: LoadingWidget(),
        );
      },
      barrierDismissible: cancelable,
    ).whenComplete(() {
      popByFuture = false;
    });

    whenComplete(() {
      if (popByFuture) {
        Navigator.of(context, rootNavigator: true).pop(this);
      }
    });
    return this;
  }

  Widget build<T>({
    required Widget Function(T data) onSuccess,
    Widget? loadingWidget,
    Widget? errorWidget,
  }) {
    return FutureBuilder<T>(
      future: this as Future<T>,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? Center(child: LoadingWidget());
        }
        final data = snapshot.data;
        if (snapshot.hasError || data == null) {
          return errorWidget ?? const Center(child: Icon(Icons.error));
        }
        return onSuccess(data);
      },
    );
  }

  Widget buildFolded<T>({
    required Widget Function(T data) onSuccess,
    Widget Function(Failure data, Function retry)? onFailure,
    Widget? loadingWidget,
  }) {
    return Futuristic<Either<Failure, T>>(
      futureBuilder: () => this as Future<Either<Failure, T>>,
      busyBuilder: loadingWidget != null
          ? (_) {
              return loadingWidget;
            }
          : null,
      errorBuilder: (_, error, retry) =>
          FailureWidget(failure: Failure(error.toString()), callback: retry),
      onData: (value, retry) => {
        value.fold((failure) {
          if (onFailure != null) {
            return onFailure(failure, retry);
          } else {
            return FailureWidget(
              failure: failure,
              callback: retry,
            );
          }
        }, onSuccess)
      },
    );
  }
}
