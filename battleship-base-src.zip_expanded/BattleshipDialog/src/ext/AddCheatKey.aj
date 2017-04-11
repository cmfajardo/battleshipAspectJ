package ext;

import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.util.ArrayList;

import javax.swing.AbstractAction;
import javax.swing.ActionMap;
import javax.swing.InputMap;
import javax.swing.JComponent;
import javax.swing.JOptionPane;
import javax.swing.KeyStroke;

import battleship.BoardPanel;
import battleship.model.Board;
import battleship.model.Place;

public privileged aspect AddCheatKey {

	before(BoardPanel board): this(board)&&execution(BoardPanel.new(..)){
		ActionMap actionMap = board.getActionMap();
		int condition = JComponent.WHEN_IN_FOCUSED_WINDOW;
		InputMap inputMap = board.getInputMap(condition);
		String cheat = "Cheat";
		Board b = board.board;
		Iterable<Place> places = b.places();
		inputMap.put(KeyStroke.getKeyStroke(KeyEvent.VK_CAPS_LOCK, 0), cheat);
		actionMap.put(cheat, new KeyAction(board, cheat, places));
	}

	@SuppressWarnings("serial")
	private static class KeyAction extends AbstractAction {
		private final BoardPanel boardPanel;
		private final Iterable<Place> places;
		public KeyAction(BoardPanel boardPanel, String command, Iterable<Place> places) {
			this.boardPanel = boardPanel;
			this.places = places;
			putValue(ACTION_COMMAND_KEY, command);
		}

		/** Called when a cheat is requested. */
		public void actionPerformed(ActionEvent event) {
			for(Place p: places){
				
			}
			boardPanel.repaint();
		}
	}

}
