import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
int octave = 4;
float duration;

void setup() {
  size(512, 200, P3D);
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw()
{
  background(0);
  stroke(255);

  // draw the waveforms
  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
    line( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
    line( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
  }

  if (keyPressed) {
    if (key == ' ') {
      duration = 1;
    } else {
      duration = 0.3;
    }
  }
}

void keyPressed() {
  if (key == 'z') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("C"+octave).asHz()));
  if (key == 's') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("C#"+octave).asHz()));
  if (key == 'x') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("D"+octave).asHz()));
  if (key == 'd') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("D#"+octave).asHz()));
  if (key == 'c') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("E"+octave).asHz()));
  if (key == 'v') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("F"+octave).asHz()));
  if (key == 'g') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("F#"+octave).asHz()));
  if (key == 'b') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("G"+octave).asHz()));
  if (key == 'h') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("G#"+octave).asHz()));
  if (key == 'n') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("A"+octave).asHz()));
  if (key == 'j') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("A#"+octave).asHz()));
  if (key == 'm') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("B"+octave).asHz()));
  if (key == ',') out.playNote(0, duration, new SineInstrument(Frequency.ofPitch("C"+str(octave+1)).asHz()));
  if (keyCode == UP) octave++;
  if (keyCode == DOWN) octave--;
}


//////////////////////////////////////////////////////////////////////////////////
///////////////////DO NOT TOUCH THE CODE BELOW THIS LINE//////////////////////////
//////////////////////////////////////////////////////////////////////////////////

class SineInstrument implements Instrument {
  Oscil wave;
  Line  ampEnv;

  SineInstrument( float frequency ) {
    wave   = new Oscil( frequency, 0, Waves.SAW );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }

  void noteOn( float duration ) {
    ampEnv.activate( duration, 0.5f, 0 );
    wave.patch( out );
  }

  void noteOff() {
    wave.unpatch( out );
  }
}
