float xOrientationOrigin;
float yOrientationOrigin;
float zOrientationOrigin;

float xGaussExampleValue;
float yGaussExampleValue;
float zGaussExampleValue;

int indexOfDisplay;

float objectOriginTranslationW;
float objectOriginTranslationH;

int scaleValue;
int lastScaleValue;
Box debugBox;
MouseHandler mh = null;
DualScrollBar dsb = null;

FlyData fd = null;

boolean hasReset;
boolean running;
void setup(){
  size(840,510, P3D);
  printMatrix();
  frameRate(25);
  
  debugBox = new Box(new Position(20,20),150,410);
  
  scaleValue = 1;
  lastScaleValue = 1;
  indexOfDisplay = 0;
  hasReset = false;
  running = false;
  
  dsb = new DualScrollBar(new Position(20,450),800,40 );
  ArrayList<MouseEventHandler> l = new ArrayList<MouseEventHandler>();
  l.add(dsb); 
  mh = new MouseHandler(l);
  
  fd = new FlyData(new FloatTable("ARGS NO USED"));
  objectOriginTranslationW = width/2+80;
  objectOriginTranslationH = height/2+120;
  translate(objectOriginTranslationW,objectOriginTranslationH,0.0);
  //translate(200,200,0.0);
  pushMatrix();
  
}
void draw(){
  if (hasReset){
    translate(-420,-255,-441.6730);
  }
  background(255);
  mh.update(mousePressed,new Position(mouseX,mouseY));
  dsb.drawBox();
  
  scaleValue = int(map(dsb.getLeftValue(),0,100,1,10));
  if (scaleValue!=lastScaleValue){
    reset();

  }else{   
    fill(0);
    debug();
    debug2();
    
    
  }
}
void debug2(){
    for(int i = 2;i<440/10;i++){
    line(30+150,i*10,820,i*10 );
  }
  popMatrix();
  fill(0);  
  if(running){
    int i = indexOfDisplay;
    translate(fd.getXTrans(i), -fd.getYTrans(i),fd.getZTrans(i));
    rotateX(fd.getXRot(i));
    rotateY(fd.getYRot(i));
    rotateZ(fd.getZRot(i));
    indexOfDisplay++;
    if(indexOfDisplay == fd.data.rowCount) indexOfDisplay =0;
  }
  noFill();
  strokeWeight(5 );
  stroke(#00FF00);
  fill(#00FF00);
  line(0,-50,0,0,0,0);
  fill(#0000FF);
  stroke(#0000FF);
  line(0,0,0,50,0,0);
  fill(#FF0000);
  stroke(#FF0000);
  line(0,0,0,0,0,50);
  stroke(#BD8D46);
  noFill();
  box(50,50,50);
  //rect(0, 0, 50, 50);   //White rectangle
  strokeWeight(1);
  pushMatrix();
  
}
void debug(){
  fill(255);
  debugBox.drawBox();
  fill(0);
  text("TIME",30,50);
  text(fd.getTime(indexOfDisplay),30,60);
  text("LINEAR DELTA-X-Y-Z",30,70);
  text(fd.getXTrans(indexOfDisplay),30,80);
  text(fd.getYTrans(indexOfDisplay),30,90);
  text(fd.getZTrans(indexOfDisplay),30,100);
  text("ANGULAR DELTA X-Y-Z",30,110);
  text(fd.getXRot(indexOfDisplay),30,120);
  text(fd.getYRot(indexOfDisplay),30,130);
  text(fd.getZRot(indexOfDisplay),30,140);
  text("SCALE VALUE",30,150);
  text(scaleValue,30,160);
  
  fill(#BD8D46);
  rect(25,170,50,12);
  rect(25,190,50,12);
  rect(25,210,50,12);
  fill(0);
  
  text("START",30,180);
  text("PAUSE",30,200);
  text("RESET",30,220);
  
  
  
}

void reset(){
  indexOfDisplay = 0 ;
  
  popMatrix();
  resetMatrix();
  translate(-420,-255,-441.6730);
  translate(objectOriginTranslationW,objectOriginTranslationH,0);
  float t = float(scaleValue);
  if(t==0) t=1;
  scale(1/t,1/t,1/t);
  lastScaleValue= scaleValue;
  
  pushMatrix();
  hasReset = true;
}

void mouseClicked( ){
  if (mouseX >25 && mouseX < 25+50 && mouseY < 170+12 && mouseY > 170){
    running = true;
  }
  if (mouseX >25 && mouseX < 25+50 && mouseY < 190+12 && mouseY > 190){
    running = false;
  }
  if (mouseX >25 && mouseX < 25+50 && mouseY < 210+12 && mouseY > 210){
    reset();
  }
}
