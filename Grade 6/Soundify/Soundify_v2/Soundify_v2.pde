import ddf.minim.*;
import java.awt.Rectangle;

Minim minim;
AudioPlayer track;
AudioMetaData info;

int trackNumber = 1;
int total = 5;
float volume = 50;
boolean paused = false;
boolean muted = false;
boolean shuffling = false;
PImage logo;
PImage Play;
PImage Pause;
PImage Next;
PImage Previous;
PImage PlayS;
PImage PauseS;
PImage NextS;
PImage PreviousS;
PImage Volume;
PImage VolumeS;
PImage Mute;
PImage MuteS;
PImage Loop;
PImage LoopS;
PImage LoopO;
PImage Shuffle;
PImage ShuffleS;
PImage ShuffleO;
PImage album;
Rectangle bar;
Rectangle vol;
Rectangle play;
Rectangle next;
Rectangle previous;
Rectangle mute;
Rectangle loop;
Rectangle shuffle;

void setup() {
  size(2000, 1000);
  minim = new Minim (this);
  track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
  track.setGain(map(volume, 0, 100, -40, 10));
  track.play();
  printInfo();
  logo = loadImage("logo.png");
  Play = loadImage("play.png");
  Pause = loadImage("pause.png");
  Next = loadImage("next.png");
  Previous = loadImage("previous.png");
  PlayS = loadImage("playS.png");
  PauseS = loadImage("pauseS.png");
  NextS = loadImage("nextS.png");
  PreviousS = loadImage("previousS.png");
  Volume = loadImage("volume.png");
  Mute = loadImage("mute.png");
  VolumeS = loadImage("volumeS.png");
  MuteS = loadImage("muteS.png");
  Loop = loadImage("loop.png");
  LoopS = loadImage("loopS.png");
  LoopO = loadImage("loopO.png");
  Shuffle = loadImage("shuffle.png");
  ShuffleS = loadImage("shuffleS.png");
  ShuffleO = loadImage("shuffleO.png");
  album = loadImage("AlbumArt.jpg");
  logo.resize(150, 150);
  Play.resize(74, 74);
  PlayS.resize(74, 74);
  Pause.resize(74, 74);
  PauseS.resize(74, 74);
  Next.resize(74, 74);
  NextS.resize(74, 74);
  Previous.resize(74, 74);
  PreviousS.resize(74, 74);
  Volume.resize(44, 44);
  VolumeS.resize(44, 44);
  Mute.resize(44, 44);
  MuteS.resize(44, 44);
  Loop.resize(74, 74);
  LoopS.resize(74, 74);
  LoopO.resize(74, 74);
  Shuffle.resize(74, 74);
  ShuffleS.resize(74, 74);
  ShuffleO.resize(74, 74);
  album.resize(400, 400);
  bar = new Rectangle(500, 930, 1000, 15);
  vol = new Rectangle(1750, 890, 200, 15);
  play = new Rectangle(width/2-75/2, 865-75/2, 75, 75);
  next = new Rectangle(width/2-75/2+150, 865-75/2, 75, 75);
  previous = new Rectangle(width/2-75/2-150, 865-75/2, 75, 75);
  mute = new Rectangle(vol.x-60, vol.y-vol.height+3, 45, 45);
  loop = new Rectangle(width/2-75/2+300, 865-75/2, 75, 75);
  shuffle = new Rectangle(width/2-75/2-300, 865-75/2, 75, 75);
}      

void draw() {
  background(30);
  runUI();
  if (paused == false && track.isPlaying() == false) {
    println("Next Song!");
    track.pause();
    if (!shuffling) {
      trackNumber = 1 + trackNumber % total;
    } else {
      trackNumber = (int)random(1, total+1);
    }
    track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
    track.setGain(map(volume, 0, 100, -40, 10));
    track.play();
    printInfo();
  }
}

void mouseClicked() {
  if (play.contains(mouseX, mouseY)) {
    if (track.isPlaying()) {
      track.pause();
      paused = true;
    } else {
      track.play();
      paused = false;
    }
  }

  if (mute.contains(mouseX, mouseY)) {
    if (!muted) {
      track.setGain(-100);
      muted = true;
    } else {
      track.setGain(map(volume, 0, 100, -40, 10));
      muted = false;
    }
  }

  if (next.contains(mouseX, mouseY)) {
    track.pause();
    if (!shuffling) {
      trackNumber = 1 + trackNumber % total;
    } else {
      trackNumber = (int)random(1, total+1);
    }
    track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
    track.setGain(map(volume, 0, 100, -40, 10));
    track.play();
    printInfo();
  }

  if (previous.contains(mouseX, mouseY)) {
    track.pause();
    if (!shuffling) {
      if (trackNumber == 1) {
        trackNumber = total;
      } else {
        trackNumber--;
      }
    } else {
      trackNumber = (int)random(1, total+1);
    }
    track = minim.loadFile(sketchPath("").substring(0, sketchPath("").length()-12)+"data/Track"+trackNumber+".mp3");
    track.setGain(map(volume, 0, 100, -40, 10));
    track.play();
    printInfo();
  }

  if (loop.contains(mouseX, mouseY)) {
    if (track.isLooping()) {
      track.play();
    } else {
      track.loop();
    }
  }

  if (shuffle.contains(mouseX, mouseY)) {
    if (shuffling) {
      shuffling = false;
    } else {
      shuffling = true;
    }
  }
}

void keyReleased() {
  if (key == ' ') {
    if (track.isPlaying()) {
      track.pause();
      paused = true;
    } else {
      track.play();
      paused = false;
    }
  }
}

void printInfo() {
  info = track.getMetaData();
  println("Playing Track "+trackNumber);
  println("Title: "+info.title());
  println("Author: "+info.author());
  println("Length: "+lengthConversion(track.length()));
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


void runUI() {
  fill(50);
  rect(0, 800, width, height);
  image(logo, 10, 10);
  progressBar();
  volumeBar();
  playButton();
  songSelectButton();
  loopButton();
  shuffleButton();
  displayInfo();
}

void progressBar() {
  fill(80);
  rect(bar.x, bar.y, bar.width, bar.height, 10);
  if (bar.contains(mouseX, mouseY)) { 
    fill(#ff7824);
    rect(bar.x, bar.y, map(track.position(), 0, track.length(), 0, bar.width), bar.height, 10);
    fill(220);
    ellipse(map(track.position(), 0, track.length(), bar.x, bar.x+bar.width), bar.y+bar.height/2, 30, 30);
    if (mousePressed) {
      track.cue(int(map(mouseX, bar.x, bar.x+bar.width, 0, track.length())));
    }
  } else {
    fill(200);
    rect(bar.x, bar.y, map(track.position(), 0, track.length(), 0, bar.width), bar.height, 10);
  }
  fill(220);
  textSize(30);
  textAlign(RIGHT, CENTER);
  text(lengthConversion(track.position()), bar.x-30, bar.y+bar.height/4);
  textAlign(LEFT, CENTER);
  text(lengthConversion(track.length()), bar.x+bar.width+30, bar.y+bar.height/4);
}

void volumeBar() {
  fill(80);
  rect(vol.x, vol.y, vol.width, vol.height, 10);
  if (muted) {
    if (mute.contains(mouseX, mouseY)) {
      image(MuteS, mute.x, mute.y);
    } else {
      image(Mute, mute.x, mute.y);
    }
  } else {
    if (mute.contains(mouseX, mouseY)) {
      image(VolumeS, mute.x, mute.y);
    } else {
      image(Volume, mute.x, mute.y);
    }
  }
  if (!muted) {
    if (vol.contains(mouseX, mouseY)) { 
      fill(#ff7824);
      rect(vol.x, vol.y, map(volume, 0, 100, 0, vol.width), vol.height, 10);
      fill(220);
      ellipse(map(volume, 0, 100, vol.x, vol.x+vol.width), vol.y+vol.height/2, 30, 30);
      if (mousePressed) {
        volume = int(map(mouseX, vol.x, vol.x+vol.width, 0, 100));
        println(volume);
        println(map(volume, 0, 100, -40, 10));
        if (volume>0) {
          track.setGain(map(volume, 0, 100, -40, 10));
          muted = false;
        } else {
          track.setGain(-100);
          muted = true;
        }
      }
    } else {
      fill(200);
      rect(vol.x, vol.y, map(volume, 0, 100, 0, vol.width), vol.height, 10);
    }
  }
}

void playButton() {
  if (track.isPlaying()) {
    if (play.contains(mouseX, mouseY)) {
      image(PauseS, play.x, play.y);
    } else {
      image(Pause, play.x, play.y);
    }
  } else {
    if (play.contains(mouseX, mouseY)) {
      image(PlayS, play.x, play.y);
    } else {
      image(Play, play.x, play.y);
    }
  }
}

void songSelectButton() {
  if (next.contains(mouseX, mouseY)) {
    image(NextS, next.x, next.y);
  } else {
    image(Next, next.x, next.y);
  }
  if (previous.contains(mouseX, mouseY)) {
    image(PreviousS, previous.x, previous.y);
  } else {
    image(Previous, previous.x, previous.y);
  }
}

void loopButton() {
  if (!track.isLooping()) {
    if (loop.contains(mouseX, mouseY)) {
      image(LoopS, loop.x, loop.y);
    } else {
      image(Loop, loop.x, loop.y);
    }
  } else {
    image(LoopO, loop.x, loop.y);
  }
}

void shuffleButton() {
  if (!shuffling) {
    if (shuffle.contains(mouseX, mouseY)) {
      image(ShuffleS, shuffle.x, shuffle.y);
    } else {
      image(Shuffle, shuffle.x, shuffle.y);
    }
  } else {
    image(ShuffleO, shuffle.x, shuffle.y);
  }
}

void displayInfo() {
  info = track.getMetaData();
  println("Playing Track "+trackNumber);
  println("Title: "+info.title());
  println("Author: "+info.author());
  println("Length: "+lengthConversion(track.length()));
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(70);
  text("Currently Playing:", width/2, 50);
  textSize(60);
  fill(#ff7824);
  text(info.title(), width/2, 600);
  textSize(50);
  fill(200);
  text(info.author()+" • "+info.album(), width/2, 700);
  image(album, width/2-200, height/2-350);
}
