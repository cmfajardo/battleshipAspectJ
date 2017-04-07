package ext;
import javax.swing.JButton;
import javax.swing.JPanel;

import battleship.*;

public privileged aspect AddStrategy {
	
	private JButton playButton = new JButton("Play");
	
	after(BattleshipDialog dialog): this(dialog)&&execution(JPanel BattleshipDialog.makeControlPane()){
		dialog.playButton.setText("Practice");
		JPanel buttons = (JPanel) dialog.playButton.getParent();
		buttons.add(playButton);
		//add extra behavior to the button
	}	
}
