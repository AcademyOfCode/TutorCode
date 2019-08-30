import ddf.minim.*;

Minim minim;
AudioPlayer track;
AudioMetaData info;

int trackNumber = 1;
int total = 5;
float volume = 100;
boolean paused = false;

void setup() {
  size(2000, 1000);
  background(255);
  minim = new Minim(this);
  track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
  track.setGain(map(volume, 0, 100, -80, 0));
  track.play();
  printInfo();
}      

void draw() {
  if (paused == false && track.isPlaying() == false) {
    println("Next Song!");
    track.pause();
    trackNumber = 1 + trackNumber % total;
    track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
    track.setGain(map(volume, 0, 100, -80, 0));
    track.play();
    printInfo();
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    track.pause();
    trackNumber = 1 + trackNumber % total;
    track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
    track.setGain(map(volume, 0, 100, -80, 0));
    track.play();
    printInfo();
  }
  if (keyCode == LEFT) {
    track.pause();
    if (trackNumber == 1) {
      trackNumber = total;
    } else {
      trackNumber--;
    }
    track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
    track.setGain(map(volume, 0, 100, -80, 0));
    track.play();
    printInfo();
  }
  if (keyCode == UP) {
    volume+=5;
    track.setGain(map(volume, 0, 100, -80, 0));
  }
  if (keyCode == DOWN) {
    volume-=5;
    track.setGain(map(volume, 0, 100, -80, 0));
  }
  if (keyCode == ' ') {
    if (track.isPlaying()) {
      paused = true;
      track.pause();
    } else {
      track.play();
      paused = false;
    }
  }
  if (key == 'r' || key == 'R') {
    track.rewind();
  }
  if (key == '.') {
    track.skip(1000);
  }
  if (key == ',') {
    track.skip(-1000);
  }
  if (key == '`') {
    track.cue(track.length()-5000);
  }
}

void printInfo() {
  info = track.getMetaData();
  println("Playing Track "+trackNumber);
  println("Title: "+info.title());
  println("Author: "+info.author());
  println("Length: "+(track.length()/60000)%60+":"+(track.length()/1000)%60);
}

String lengthConversion(int MS) {
  int totalSec = (MS / 1000);
  int seconds = (MS / 1000) % 60;
  int minutes = (MS / (1000*60)) % 60;
  String HumanTime;
  if (seconds<10) {
    HumanTime = (minutes+":0"+seconds);
  } else {
    HumanTime = (minutes+":"+seconds);
  }
  return (HumanTime);
}
