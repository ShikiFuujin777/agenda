class ArrayUtils {
  static List<T> listBuilder<T, K>(
    List<K> list, {
    required T Function(int, K) itemBuilder,
    required T Function(int) addedItemBuilder,
  }) {
    return List<T>.generate(
      list.length * 2 - 1,
      (index) {
        if (index % 2 == 0) {
          final indexOffset = index ~/ 2;

          return itemBuilder.call(
            indexOffset,
            list[indexOffset],
          );
        }

        return addedItemBuilder.call(
          (index - 1) ~/ 2,
        );
      },
    );
  }
}

extension ArrayUtilsExtension<K> on List<K> {
  List<T> builder<T>({
    required T Function(int, K) itemBuilder,
    required T Function(int) addedItemBuilder,
  }) {
    return ArrayUtils.listBuilder(
      this,
      itemBuilder: itemBuilder,
      addedItemBuilder: addedItemBuilder,
    );
  }
}
