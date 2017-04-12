package ext;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.List;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.util.ArrayList;

import javax.swing.AbstractAction;
import javax.swing.ActionMap;
import javax.swing.InputMap;
import javax.swing.JComponent;
import javax.swing.KeyStroke;

import battleship.BoardPanel;
import battleship.model.Board;
import battleship.model.Place;

public privileged aspect AddCheatKey {

	static Boolean flag = false;
	Iterable<Place> places;
	int leftMargin;
	int topMargin;
	int placeSize;

	after(Graphics gr):within(battleship.BoardPanel) &&execution(void paint(Graphics)) && args(gr){
		if (flag) {
			cheat(gr);
		}
	}

	private void cheat(Graphics g) {
		final Color oldColor = g.getColor();
		for (Place p : places) {
			if (p.hasShip()) {
				int x = leftMargin + (p.getX() - 1) * placeSize;
				int y = topMargin + (p.getY() - 1) * placeSize;
				System.out.println("Ship at " + x + " " + y);
				g.setColor(Color.GREEN);
				g.fillRect(x + 1, y + 1, placeSize - 1, placeSize - 1);
				if (p.hasShip() && p.ship().isSunk()) {
					g.setColor(Color.BLACK);
					g.drawLine(x + 1, y + 1, x + placeSize - 1, y + placeSize - 1);
					g.drawLine(x + 1, y + placeSize - 1, x + placeSize - 1, y + 1);
				}
			}
		}
		g.setColor(oldColor);
		flag = false;

	}

	after(BoardPanel boardPanel): this(boardPanel)&&execution(BoardPanel.new(..)){
		ActionMap actionMap = boardPanel.getActionMap();
		int condition = JComponent.WHEN_IN_FOCUSED_WINDOW;
		InputMap inputMap = boardPanel.getInputMap(condition);
		String cheat = "Cheat";
		Board b = boardPanel.board;
		places = b.places();
		leftMargin = boardPanel.leftMargin;
		topMargin = boardPanel.topMargin;
		placeSize = boardPanel.placeSize;
		inputMap.put(KeyStroke.getKeyStroke(KeyEvent.VK_CAPS_LOCK, 0), cheat);
		actionMap.put(cheat, new KeyAction(boardPanel));
	}

	@SuppressWarnings("serial")
	private static class KeyAction extends AbstractAction {
		private final BoardPanel boardPanel;

		public KeyAction(BoardPanel boardPanel) {
			this.boardPanel = boardPanel;
		}
		/** Called when a cheat is requested. */
		public void actionPerformed(ActionEvent event) {
			boardPanel.repaint();
			flag = true;
		}

	}
}
