package ext;

import java.io.IOException;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

public privileged aspect AddSound {
	/** Directory where audio files are stored. */
	private static final String SOUND_DIR = "/sounds/";

	/** Introduce sound at the moment when hit method is called*/
	pointcut hitShip(): execution (void *.hit());
	after(): hitShip(){
		playAudio("blast.wav");
	}
	
	/** Introduce sound at the moment when a ship sinks*/
	pointcut sinkShip(): execution (void *.notifyShipSunk(..));
	after(): sinkShip(){
		playAudio("sonic.wav");
	}
	/** Play the given audio file. Inefficient because a file will be 
	 * (re)loaded each time it is played. */
	public static void playAudio(String filename) {
		try {
			AudioInputStream audioIn = AudioSystem.getAudioInputStream(
					AddSound.class.getResource(SOUND_DIR + filename));
			Clip clip = AudioSystem.getClip();
			clip.open(audioIn);
			clip.start();
		} catch (UnsupportedAudioFileException 
				| IOException | LineUnavailableException e) {
			e.printStackTrace();
		}
	}

}
