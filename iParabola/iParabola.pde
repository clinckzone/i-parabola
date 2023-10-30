import g4p_controls.*;

float x1; //These two variables here, x1 and y1 store the x and y 
float y1; //positions of the corresponding control point that they represent

float x2; //Same here :)
float y2;

float x3; //and here  :)
float y3;

boolean tag1 = false; //These variables help in better handling of
boolean tag2 = false; //their corresponding control points
boolean tag3 = false;

boolean showGrid = true;
boolean showParabola = true;

ArrayList<PVector> line1;
ArrayList<PVector> line2;
ArrayList<PVector> interPoints;

float lineWeight = 3;
int detail = 10; //used for controlling smoothness of the parabola

PGraphics pg;

void setup() {
  smooth();
  size(800, 600);
  background(250);
  
  pg = createGraphics(8*width/10, height);  
  createGUI();
  
  PFont newFont = loadFont("ArialRoundedMTBold-48.vlw");
  fill(50);
  textFont(newFont);
  textSize(16);
  text("Line Weight", 655, 185);
  text("Detail Level", 655, 265);
  textSize(15);
  text("Hide Grid", 670, 345);
  
  x1 = pg.width/2;
  y1 = pg.height/4;
  
  x2 = pg.width/4;
  y2 = pg.width/2;
  
  x3 = pg.width/2;
  y3 = 3*pg.height/4;
  
  line1 = new ArrayList<PVector>();
  line2 = new ArrayList<PVector>();
  interPoints = new ArrayList<PVector>();
}

void draw() {  
  pg.beginDraw();  
    pg.background(255);
    drawParabola();   //this function draws a parabola(algorithm inspired by the parabolic string art)
    display();        //displays all the three control points along with the two lines that connects them
    controlC1();      //these three functions share the same functionality(see controlC1 for details)
    controlC2();
    controlC3();  
  pg.endDraw();
  image(pg, 0, 0);
}

void keyPressed() {  
    if(keyCode == UP)  {
      detail++;
    }
    else if(keyCode == DOWN)  {
      if(detail == 1) {
        print("Limit reached !! ");
      }
      else {
        detail--;
      }
    }     
}

void display()  {  
  pg.stroke(0);
  if(showGrid == true)  {
    pg.line(x3, y3, x2, y2);
    pg.line(x1, y1, x2, y2);
  }
  pg.fill(255, 255, 0);
  pg.noStroke();  
  pg.ellipse( x1, y1, 20, 20);
  pg.ellipse( x2, y2, 20, 20);
  pg.ellipse( x3, y3, 20, 20);
}

/*
Algorithm :
----------
Divide line joining c1(1st control point at the corner) and c2(2nd control point at the middle) into 'n' parts.
Similarly, divide line joining c2 and c3 into 'n' parts. Mark 'n' division points on c2-c1 line starting from 
(x1, y1) itself. Similarly mark 'n' division points on c2-c3 line starting from (x3, y3) itself. 
Now join the 'i'th division point(from c1) to 'n - i'th division point(from c3). The result will be a parabola :') 
*/
void drawParabola()  {
    line1.clear();
    line2.clear();
    interPoints.clear();
    
    for(int i  = detail; i != 0; i--)  {
      float x_a = ((i*x1) + ((detail-i)*x2))/detail ;
      float y_a = ((i*y1) + ((detail-i)*y2))/detail ;
      float x_b = ((i*x2) + ((detail-i)*x3))/detail ;
      float y_b = ((i*y2) + ((detail-i)*y3))/detail ;
      
      line1.add(new PVector(x_a, y_a));
      line2.add(new PVector(x_b, y_b));
      
      if(showGrid == true)  {
        pg.fill(0);
        pg.stroke(0);
        pg.ellipse(x_a, y_a, 3, 3);
        pg.ellipse(x_b, y_b, 3, 3);
        pg.line(x_a, y_a, x_b, y_b);
      }
    }  
    
    for(int i = 0; i < detail - 1; i++)  {
      PVector p11 = line1.get(i);
      PVector p12 = line2.get(i);
      
      PVector p21 = line1.get(i + 1);
      PVector p22 = line2.get(i + 1);
      
      float _x = ((p11.x*p12.y - p11.y*p12.x)*(p21.x - p22.x) - (p11.x - p12.x)*(p21.x*p22.y - p21.y*p22.x))/((p11.x - p12.x)*(p21.y - p22.y) - (p11.y - p12.y)*(p21.x - p22.x));
      float _y = ((p11.x*p12.y - p11.y*p12.x)*(p21.y - p22.y) - (p11.y - p12.y)*(p21.x*p22.y - p21.y*p22.x))/((p11.x - p12.x)*(p21.y - p22.y) - (p11.y - p12.y)*(p21.x - p22.x));
      
      
      interPoints.add(new PVector(_x, _y));
      
    }
    
    interPoints.add(0, new PVector(x1, y1));
    interPoints.add((line2.get(line1.size() - 1)));
    interPoints.add(new PVector(x3, y3));
    
    if(showParabola == true)  {
      for(int i = 0; i < interPoints.size() - 1; i++)  {
        pg.pushStyle();
          pg.stroke(0, 225, 0);
          pg.strokeWeight(lineWeight);
          pg.line(interPoints.get(i).x, interPoints.get(i).y, interPoints.get(i + 1).x, interPoints.get(i + 1).y);
        pg.popStyle();
      }
    }
}

void controlC1()  {
    //if cursor is over the control point with mouse pressed then move it with the cursor
    if( (mouseX<=(x1+20)) && (mouseX>=(x1-20)) && (mouseY<=(y1+20)) && (mouseY>=(y1-20)) && mousePressed )  {
      x1 = mouseX;
      y1 = mouseY;
      tag1 = true;
    } 
    //else if the control point is already moving with the cursor with the 
    //mouse button still being pressed, keep the control point moving with the cursor
    else if( tag1 == true && mousePressed)  {
      x1 = mouseX;
      y1 = mouseY;
    }
    //else leave it alone
    else  {
      tag1 = false;
    }
}

void controlC2()  {
    if( (mouseX<=(x2+20)) && (mouseX>=(x2-20)) && (mouseY<=(y2+20)) && (mouseY>=(y2-20)) && mousePressed )  {
      x2 = mouseX;
      y2 = mouseY;
      tag2 = true;
    }
    else if( tag2 == true && mousePressed)  {
      x2 = mouseX;
      y2 = mouseY;
    }
    else  {
      tag2 = false;
    }
}

void controlC3()  {
    if( (mouseX<=(x3+20)) && (mouseX>=(x3-20)) && (mouseY<=(y3+20)) && (mouseY>=(y3-20)) && mousePressed )  {
      x3 = mouseX;
      y3 = mouseY;
      tag3 = true;
    }
    else if( tag3 == true && mousePressed)  {
      x3 = mouseX;
      y3 = mouseY;
    }
    else  {
      tag3 = false;
    }
}