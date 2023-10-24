int BLOCKSIZE = 25;
int[] green = {0, 220, 0};
int[] red = {220, 0, 0};
int[] blue = {0, 0, 220};
int[] startingpos = {randInt(20, 38), randInt(15, 28)};
int[] snakedir = {0, 0};
/*
    snakedir[0]: x direction
    snakedir[1]: y direction
    Java's vector system is too bloated so I'm just making my own)
*/
// Rect testrect = new Rect(3, 8);
boolean alive = true;
boolean began = false;
Rect apple = new Rect(randInt(2, 30), randInt(2, 30));
Snake snake = new Snake(4, startingpos[0], startingpos[1]);

void setup() {
  size(1025, 750);
  windowTitle("Snake Clone - Synnøve Olsdatter");
}

void draw() {
    background(102);
    setcolor(green);
    /*
    for (int i = 0; i < 4; i++) {
        snake.snak[i].pos[0] = randInt(2, 40);
        snake.snak[i].pos[1] = randInt(2, 30);
    }
    */
    if (began) {
        for (int i = 1; i < snake.len; i++) {
          if (snake.snak[0].pos[0] == snake.snak[i].pos[0] && snake.snak[0].pos[1] == snake.snak[i].pos[1]) {
            alive = false;
          }
        }
    }
    snake.bloop();
    if (!alive) {
      textSize(112);
      text("You Died!", 0, displayHeight / 3);
      textSize(52);
      text("Sorry about that one", 0, displayHeight / 2);
    }
    setcolor(red);
    for (int i = 0; i < snake.len; i++) {
        if (snake.snak[i].pos[0] == apple.pos[0] && snake.snak[i].pos[1] == apple.pos[1]) {
            snake.omnomnom();
            randomiseApplePos();
        }
    }
    apple.draw();
    System.out.println("Apple Pos: { " + apple.pos[0] + ", " + apple.pos[1] + " }");
    try {
      Thread.sleep(50);
    } catch (InterruptedException e) {
      System.out.println("agh");
      alive = false;
    }
}

void randomisepos(Rect rect) {
        rect.setpos(randInt(15, 40), randInt(1, 30));
    }

void keyPressed() {
    if (key == 'w' || key == 'W' || keyCode == UP) {
        if (snake.snak[0].pos[1] - 1 == snake.snak[1].pos[1]) {
            //alive = false;
        } else {
          goup();
        }
    }
    if (key == 'a' || key == 'A' || keyCode == LEFT) {
        if (snake.snak[0].pos[0] - 1 == snake.snak[1].pos[0] ) {
            //alive = false;
        } else {
          totheleft();
        }
    }
    if (key == 'd' || key == 'D' || keyCode == RIGHT) {
        if (snake.snak[0].pos[0] + 1 == snake.snak[1].pos[0]) {
            //alive = false;
        } else {
          totheright();
        }
    }
    if (key == 's' || key == 'S' || keyCode == DOWN) {
        if (snake.snak[0].pos[1] + 1 == snake.snak[1].pos[1]) {
            //alive = false;
        } else {
          downerman();
        }
    }
}

void setcolor(int[] colo) {
    fill(colo[0], colo[1], colo[2]);
}

void randomiseApplePos() {
    apple.setpos(randInt(2, 40), randInt(2, 29));
}

class Snake {
    int len = 3;
    int[] curpos = new int[2];
    Rect[] snak = new Rect[4];
    Snake(int len, int x, int y) {
        //this.snak = new Rect(pos[0], pos[1])[len];
        for (int i = 0; i < len; i++) {// this loops is here because the compiler didnt want to
            this.snak[i] = new Rect(x, y);// take commented out one for some reason
        }
        this.curpos[0] = x;
        this.curpos[1] = y;
        for (int i = 0; i < len; i++) {
            this.snak[i] = new Rect(x, y);
        }
    }
    void bloop() {// TODO: update function name
        this.len = this.snak.length - 1;
        if (alive) {
            int blockx = this.snak[0].pos[0] + snakedir[0];
            int blocky = this.snak[0].pos[1] + snakedir[1];
            this.snak[this.len].setpos(blockx, blocky);
            //System.out.println("Pos: { " + this.snak[len].pos[0] + ", " + this.snak[len].pos[1] + " }");
            Rect[] nytt = new Rect[this.len + 1];
            Rect forste = this.snak[this.len];
            for (int i = 0; i < this.len; i++) {
                 nytt[i+1] = this.snak[i];
            }  
            nytt[0] = forste;
            nytt[0].setpos(blockx, blocky);
            this.snak = nytt;
        }
        for (int i = 0; i < this.len; i++) {
          this.snak[i].draw();
        }
        if (snake.snak[0].pos[0] >= 41 || snake.snak[0].pos[1] >= 31 || snake.snak[0].pos[0] < 0 || snake.snak[0].pos[1] < 0) {
          alive = false;
        }
    }
    void omnomnom() {// when snake eats apple
        int newlen = this.snak.length;
        int morenewlen = newlen + 1;
        Rect[] tmpsave = new Rect[morenewlen];
        for (int i = 0; i < newlen; i++) {
            tmpsave[i] = this.snak[i];
        }
        began = true;
        /*
        int lastx = this.snak[this.len].pos[0];
        int lasty = this.snak[this.len].pos[1];
        System.out.println("newlen: " + newlen);
        tmpsave[newlen].setpos(lastx, lasty);
        */
//        tmpsave[newlen] = tmpsave[newlen - 1];
        tmpsave[newlen] = new Rect(0, 0);
        int lastx = this.snak[newlen - 1].pos[0];
        int lasty = this.snak[newlen - 1].pos[1];
        tmpsave[newlen].setpos(lastx, lasty);
        this.snak = tmpsave;
        tmpsave = null;
        System.gc();
        // garbage collector please save me i dont know how to delete these
    }
}
//-------------------------------------------------------------------------------------------------------------------
void goup() {// go-up
    snakedir[0] = 0;
    snakedir[1] = -1;
}
void downerman() {
    snakedir[0] = 0;
    snakedir[1] = 1;
}
void totheright() {
    snakedir[0] = 1;
    snakedir[1] = 0;
}
void totheleft() {
    snakedir[0] = -1;
    snakedir[1] = 0;
}