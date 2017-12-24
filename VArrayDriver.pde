public static final int PADDING = 50;
public static final int ROW_SIZE = 20;

VArray va;
Integer[] values;
int nextSleep = 0;

void setup() {
  size(800, 800);
  
  values = new Integer[ROW_SIZE * ROW_SIZE];
  
  for (int i = 0; i < values.length; i++) {
    values[i] = (int) random(256);
  }
  
  va = new VArray(values, PADDING, ROW_SIZE);
 
  //Sorter.selectionSort(va);
  //Sorter.insertionSort(va);
  //Sorter.quickSort(va);
  Sorter.heapSort(va);
}

void draw() {
  if (va.drawNext() < 0) {
    va.reDraw();
  }
  
  /*try { Thread.sleep(1); }
  catch (Exception e) {}*/
}