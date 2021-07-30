class Failure {
  final String? _message;

  get message => _message ?? 'Something went wrong';

  const Failure(this._message);
}
