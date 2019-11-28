int sortNumberAsc(double a, double b) => a.compareTo(b);

int sortNumberDesc(double a, double b) => b.compareTo(a);

List<double> sortNumbers({List<double> collection, bool asc = true}) {
  List<double> shallowCopy = [...collection];
  shallowCopy.sort(asc ? sortNumberAsc : sortNumberDesc);
  return shallowCopy;
}
