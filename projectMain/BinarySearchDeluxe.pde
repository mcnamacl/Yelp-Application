/*
import java.lang.*;
import java.util.*;
import java.util.Comparator;

static class BinarySearchDeluxe {

  // Return the index of the first key in a[] that equals the search key, or -1 if no such key.
  public static <Key> int firstIndexOf(Key[] a, Key key, Comparator<Key> comparator) {
    if (a == null || key == null || comparator == null) {
      throw new java.lang.NullPointerException();
    }
    if (a.length == 0) {
      return -1;
    }
    int l = 0;
    int r = a.length - 1;
    while (l + 1 < r) {
      int mid = l + (r - l) / 2;
      if (comparator.compare(key, a[mid]) <= 0) {
        r = mid;
      } else {
        l = mid;
      }
    }
    if (comparator.compare(key, a[l]) == 0) {
      return l;
    }
    if (comparator.compare(key, a[r]) == 0) {
      return r;
    }
    return -1;
  }

  // Return the index of the last key in a[] that equals the search key, or -1 if no such key.
  public static <Key> int lastIndexOf(Key[] a, Key key, Comparator<Key> comparator) {
    if (a == null || key == null || comparator == null) {
      throw new java.lang.NullPointerException();
    }
    if (a == null || a.length == 0) {
      return -1;
    }
    int l = 0;
    int r = a.length - 1;
    while (l + 1 < r) {
      int mid = l + (r - l) / 2;
      if (comparator.compare(key, a[mid]) < 0) {
        r = mid;
      } else {
        l = mid;
      }
    }
    if (comparator.compare(key, a[r]) == 0) {
      return r;
    }
    if (comparator.compare(key, a[l]) == 0) {
      return l;
    }
    return -1;
  }
}*/