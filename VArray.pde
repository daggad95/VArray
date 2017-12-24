import java.util.LinkedList;
import java.util.HashSet;

class VArray {
  public static final int TYPE = 0;
  public static final int INDEX = 1;
  public static final int VALUE = 2;
  public static final int HIGHLIGHT = 3;
  public static final int UPDATE = 4;
  public static final int COMPARE = 5;
  public static final int COMPARE_IDX_1 = 1;
  public static final int COMPARE_IDX_2 = 2;
  
  private Integer[] values;
  private Integer[] origValues;
  private LinkedList<Integer[]> commands;
  private int padding;
  private int rowSize;
  private int currentCommand;
  private int numCommands;
  
  public VArray(Integer[] values, int padding, int rowSize) {
    this.values = values;
    this.padding = padding;
    this.rowSize = rowSize;
    
    commands = new LinkedList<Integer[]>();
    
    origValues = new Integer[values.length];
    System.arraycopy(values, 0, origValues, 0, values.length);
    currentCommand = 0;
    numCommands = 0;
  }
  
  private void draw(HashSet<Integer> highlight, color hlColor) {
    int sideLen = (width - padding * 2) / rowSize;
    int x;
    int y;
    
    textSize(sideLen / 4);
    
    for (int i = 0; i < values.length; i++) {
      if (highlight.contains(i))
        fill(hlColor);
      else
        fill(255 - values[i], 0, 0);
      x = sideLen * (i % rowSize) + padding;
      y = sideLen * (i / rowSize) + padding;
      rect(x, y, sideLen, sideLen);
      
     
      fill(values[i]);
      text(values[i], x + sideLen / 4, y + sideLen / 2);
    }
  }
  
  public void reDraw() {
    draw(new HashSet<Integer>(), 0);
  }
  
  public int drawNext() {
    if (currentCommand >= numCommands)
      return -1;
      
    Integer command[] = commands.remove();
    commands.add(command);
    
    HashSet<Integer> highlight = new HashSet<Integer>();
    
    if (command[TYPE] == UPDATE) {
      if (command[HIGHLIGHT] == 1)
        highlight.add(command[INDEX]);
      
      values[command[INDEX]] = command[VALUE];
      
      if (command[HIGHLIGHT] == 1)
        draw(highlight, color(0, 255, 0));
    }
    else if (command[TYPE] == COMPARE) {
      highlight.add(command[COMPARE_IDX_1]);
      highlight.add(command[COMPARE_IDX_2]);
      draw(highlight, color(0, 255, 255));
    }
    currentCommand++;
    return command[TYPE];
  }
  
  public void reset() {
    System.arraycopy(origValues, 0, values, 0, values.length);
    currentCommand = 0;
  }
  
  public void setValue(int index, int value, int highlight) {
    commands.add(new Integer[] {UPDATE, index, value, highlight});
    numCommands++;
    values[index] = value;
  }
  
  public int compare(int index1, int index2) {
    commands.add(new Integer[] {COMPARE, index1, index2});
    numCommands++;
    
    if (values[index1] < values[index2])
      return -1;
    if (values[index1] > values[index2])
      return 1;
    else 
      return 0;
  }
  
  public int getValue(int index) {
    return values[index];
  }
  
  public int getSize() {
    return values.length;
  }
}