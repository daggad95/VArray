static class Sorter {
  
  static void selectionSort(VArray array) {
    int size = array.getSize();
    
    for (int i = 0; i < size; i++) {
      int minIndex = i;
      
      for (int j = i + 1; j < size; j++) {
        if (array.getValue(j) < array.getValue(minIndex)) {
          minIndex = j;
        }
      }
      
      int min = array.getValue(minIndex);
      if (minIndex != i) {
        array.compare(i, minIndex);
        array.setValue(minIndex, array.getValue(i), 0);
        array.setValue(i, min, 1);
      }
    }
    
    array.reset();
  }
  
  static void insertionSort(VArray array) {
    int size = array.getSize();
    
    for (int i = 2; i < size; i++) {
      int j = i;
      int value = array.getValue(j);
      
      while (j > 0 && value < array.getValue(j - 1)) {
        array.setValue(j, array.getValue(j - 1), 1);
        j--;
      }
      
      array.setValue(j, value, 1); 
    }
    
    array.reset();
  }
  
  static void quickSort(VArray array) {
    quickSortHelper(array, 0, array.getSize() - 1);
    array.reset();
  }
  
  static void quickSortHelper(VArray array, int p, int r) {
    if (p < r) {
      int q = partition(array, p, r);
      quickSortHelper(array, p, q - 1);
      quickSortHelper(array, q + 1, r);
    }
  }
  
  static int partition(VArray array, int p, int r) {
    int x = array.getValue(r);
    int i = p - 1;
    int j;
    
    for (j = p; j < r; j++) {
      int val = array.getValue(j);
      
      if (val < x) {
        array.setValue(j, array.getValue(i + 1), 1);
        array.setValue(i + 1, val, 1);
        i++;
      }
    }
    
    array.setValue(r, array.getValue(i + 1), 1);
    array.setValue(i + 1, x, 1);
    return i + 1;
  }
  
  static void maxHeapify(VArray array, int i, int heapsize) {
    int left = 2 * i;
    int right = 2 * i + 1;
    int largest;
    
    if (left < heapsize && array.getValue(left) > array.getValue(i))
      largest = left;
    else 
      largest = i;
    
    if (right < heapsize && array.getValue(right) > array.getValue(largest))
      largest = right;
    
    if (largest != i) {
      int val = array.getValue(largest);
      array.setValue(largest, array.getValue(i), 1);
      array.setValue(i, val, 1);
      
      maxHeapify(array, largest, heapsize);
    }
  }
  
  static void buildMaxHeap(VArray array) {
    int heapsize = array.getSize();
    
    for (int i = heapsize / 2; i >= 0; i--) {
      maxHeapify(array, i, heapsize);
    }
    
    //array.reset();
  }
  
  static void heapSort(VArray array) {
    buildMaxHeap(array);
    int size = array.getSize();
    
    for (int i = 0; i < size; i++) {
      int lastUnsorted = array.getValue(size - 1 - i);
      
      array.setValue(size - 1 - i, array.getValue(0), 1);
      array.setValue(0, lastUnsorted, 1);
      maxHeapify(array, 0, size - i);
    }
    array.reset();
  }
}