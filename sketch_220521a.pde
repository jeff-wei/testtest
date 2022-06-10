int[] bx = {200,400,600,200,400,600,200,400,600};
int[] by = {200,200,200,400,400,400,600,600,600};
int[] px = new int[9];
int[] py = new int[9];
int k = 0;

void setup() {
    size(800 , 800);
    
    getQuestion(8);
}

void draw() {
    background(10);
    
    if (frameCount % 100 ==  0) {
        k = 0;
        getQuestion(8);
    }
    
    for (int i = 0; i < 9; i = i + 1) {
        
        // 設定雷達 : distance
        if (dist(bx[i] , by[i] , mouseX , mouseY) <80) {
            fill(0,200,0);  // 綠
        } else{
            fill(100,100,100); // 灰
        }
        
        // 每一顆球
        circle(bx[i] , by[i] , 50);
    }
    
    // 畫線
    strokeWeight(3);
    stroke(200,200,0);
    for (int i = 0; i < k - 1; i = i + 1) {
        if (px[i + 1] ==  0) {
            break;
        }
        line(px[i],py[i],    px[i + 1],py[i + 1]);
    }
    
}



void mouseClicked() {    
    
    for (int i = 0; i < 9; i = i + 1) {        
        // 設定雷達
        if (dist(bx[i] , by[i] , mouseX , mouseY) <80) {
            // 請管理員 k 寄放
            px[k] = bx[i];
            py[k] = by[i];
            
            // k 往前走一步
            k = k + 1;
        }        
    }
    
    
}


// 產生題目的工廠（函式、方法）
void getQuestion(int qsize) {
    
    // 記住，哪些球已經使用了
    boolean[] cho = new boolean[10];
    
    // 永遠使用 1 號當作第一顆球
    // 請管理員 k 寄放
    int ball = 1;
    px[k] = bx[ball - 1];
    py[k] = by[ball - 1];            
    // k 往前走一步
    k = k + 1;  
    cho[ball] = true; // 記住 1 號已經使用了
    
    for (int i = 0; i < qsize - 1; ++i) {
        int a = nextBall(ball);
        while(cho[a] == true) {
            a = nextBall(ball); // 再抽一次
        }
        // 記下這顆球
        ball = a;
        px[k] = bx[ball - 1];
        py[k] = by[ball - 1];                    
        k = k + 1;          
        cho[ball] = true;
    }  
}

// 隨機找下一球
int nextBall(int i) {
    // 1:2,4,5,6,8
    // 3:2,4,5,6,8
    // 7:2,4,5,6,8
    // 9:2,4,5,6,8
    // 5:1,2,3,4,6,7,8,9
    // 2:1,3,4,5,6,7,9
    // 4:1,2,5,7,8,3,9
    // 6:3,2,5,8,9,1,7
    // 8:7,4,1,5,3,6,9
    if (i == 1 || i ==  3 || i ==  7 || i ==  9) {
        int[] next = {2,4,5,6,8};
        return pickRandom(next);
        // int[] next = new int[5];
        // next[0] = 2;
        // next[1] = 4;
        // next[2] = 5;
        // next[3] = 6;
        // next[4] = 8;
        
        // 1. 抽籤
        // 2. 不能用過
    } else if (i ==  2) {
        int[] next = {1,3,4,5,6,7,9};
        return pickRandom(next);
    } else if (i ==  4) {
        int[] next = {1,2,5,7,8,3,9};
        return pickRandom(next);
    } else if (i ==  5) {
        int[] next = {1,2,3,4,6,7,8,9};
        return pickRandom(next);
    } else if (i ==  6) {
        int[] next = {3,2,5,8,9,1,7};
        return pickRandom(next);
    } else if (i ==  8) {
        int[] next = {7,4,1,5,3,6,9};
        return pickRandom(next);
    }
    return 0;
}

// 抽籤工廠（工廠、函式、方法）
int pickRandom(int[] items) {
    // items = { 4,2,7 } : 門牌 0 , 1 , 2
    // items.length : 3  
    // random( items.length )  ==>
    // random(  3  )  ==> 0,1,2,3(x) 
    // int( ... ) ==> 去掉小數。不是 4 捨 5 入
    
    // 抽：超級倉庫的，門牌號碼
    int i = int(random(items.length));
    
    return items[i];  //A. 超級倉庫的門牌  return i ; X
    //B. i 這個門牌的倉庫內容 ; V
}