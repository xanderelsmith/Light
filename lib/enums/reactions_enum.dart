enum Reaction {
  like('like', 0),
  none('none', -1),
  dislike('dislike', 1);

  const Reaction(this.value, this.num);
  final String value;
  final int num;
}
