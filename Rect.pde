class Rect {
    int[] pos = new int[2];// pos[0] = x, pos[1] = y
    Rect(int x, int y) {
        this.pos[0] = x;
        this.pos[1] = y;
    }
    void setpos(int x, int y) {
        this.pos[0] = x;
        this.pos[1] = y;
    } 
    void draw() {
        rect(this.pos[0] * BLOCKSIZE, this.pos[1] * BLOCKSIZE, BLOCKSIZE, BLOCKSIZE);// params: x, y, sx, sy
    }
}