package ext;

import java.awt.event.ActionEvent;
import javax.swing.AbstractAction;
import javax.swing.ActionMap;
import javax.swing.InputMap;
import javax.swing.JPanel;
import battleship.BoardPanel;


public privileged aspect AddCheatKey{
	
	after(BoardPanel board): this(board)&&execution(void BoardPanel.drawGrid(..)){
    /**Inyectar este codigo a BoardPanel Class*/
	/*ActionMap actionMap = getActionMap();
	int condition = JComponent.WHEN_IN_FOCUSED_WINDOW;
	InputMap inputMap = getInputMap(condition);
	String cheat = "Cheat";
	inputMap.put(KeyStroke.getKeyStroke(KeyEvent.VK_F5, 0), cheat);
	actionMap.put(cheat, new KeyAction(this, cheat));*/

	}
	@SuppressWarnings("serial")
    private static class KeyAction extends AbstractAction {
       private final BoardPanel boardPanel;
       
       public KeyAction(BoardPanel boardPanel, String command) {
           this.boardPanel = boardPanel;
           putValue(ACTION_COMMAND_KEY, command);
       }
       
       /** Called when a cheat is requested. */
       public void actionPerformed(ActionEvent event) {
           // to be executed when the cheat (F5) key is pressed.
           // ...
       }   
    }

}

