double getSize(double min, double screenWidth, { double space = 0.0, double screenSpace = 0.0, bool show = false }){
  final double available = screenWidth - screenSpace;
  final double max = min * 2 - space;
  if (available <= min) {
    return available > 0 ? available : screenWidth;
  }
  final double avg = (min + max) / 2;
  int count = (available + space) ~/ (avg + space);
  if(count < 1) count = 1;

  double width = (available - space * (count - 1)) / count;
  if(width > max){
    final int correctionalCount = count + 1;
    final double correctionalWidth = (available - space * (correctionalCount - 1)) / correctionalCount;
    if(correctionalWidth >= min) return correctionalWidth;
    return max;
  }

  return width;
}