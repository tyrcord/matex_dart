int sortNumberAsc(double a, double b) => a.compareTo(b);

int sortNumberDesc(double a, double b) => b.compareTo(a);

List<double> sortNumbers({required List<double> collection, bool asc = true}) {
  var shallowCopy = [...collection];
  shallowCopy.sort(asc ? sortNumberAsc : sortNumberDesc);

  return shallowCopy;
}
