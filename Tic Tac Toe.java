import java.io.*;
import java.util.*;

class TicTacToe{
    int HUMAN = -1;
    int COMP = +1;
    int[][] board = new int[3][3];

    TicTacToe(){
        for (int i = 0; i < 3; i++) {
            for(int j = 0; j < 3; j++){
                board[i][j] = 0;
            }
        }
    }

    public int evaluate(int[][] state){
        int score;
        if (wins(state, COMP)) {
            score = +1;
        }
        else if(wins(state, HUMAN)){
            score = -1;
        }
        else{
            score = 0;
        }
        return score;
    }

    public boolean wins(int[][] state, int player){
        int win_state[][]={
            {state[0][0], state[0][1], state[0][2]},
            {state[1][0], state[1][1], state[1][2]},
            {state[2][0], state[2][1], state[2][2]},
            {state[0][0], state[1][0], state[2][0]},
            {state[0][1], state[1][1], state[2][1]},
            {state[0][2], state[1][2], state[2][2]},
            {state[0][0], state[1][1], state[2][2]},
            {state[0][2], state[1][1], state[2][0]}
        };

        boolean flag = false;

        for (int i = 0; i < 8; i++) {
            if((win_state[i][0] == player) && (win_state[i][1] == player) && (win_state[i][2] == player)){
                flag = true;
                break;
            }
        }
        return flag;
    }

    public boolean is_game_over(int[][] state){
        if(wins(state, HUMAN) || wins(state, COMP)){
            return true;
        }
        else{
            return false;
        }
    }

    public int[][] list_of_empty_cells(int[][] state){
        // Calculate number of empty cells
        int count = 0;
        for (int i = 0; i < state.length; i++) {
            for (int j = 0; j < state[i].length; j++) {
                if(state[i][j] == 0){
                    count++;
                }
            }
        }

        int[][] cells = new int[count][2];

        count = 0;
        for (int i = 0; i < state.length; i++) {
            for (int j = 0; j < state[i].length; j++) {
                if(state[i][j] == 0){
                    cells[count][0] = i;
                    cells[count][1] = j;
                    count++;
                }
            }
        }

        return cells;
    }

    public boolean is_valid_move(int x, int y){
        boolean is_valid = false;
        int[][] cells = list_of_empty_cells(board);
        for(int i = 0; i < cells.length; i++){
            if(cells[i][0] == x && cells[i][1] == y){
                is_valid = true;
                break;
            }
        }
        return is_valid;
    }

    public boolean set_move(int x, int y, int player){
        if(is_valid_move(x, y)){
            board[x][y] = player;
            return true;
        }
        else
            return false;
    }

    public int[] minimax(int[][] state, int depth, int player){
        int[] best = new int[3];
        int score2, x, y;
        int[] score;
        if(player == COMP){
            best[0] = -1;
            best[1] = -1;
            best[2] = -200;
        }
        else{
            best[0] = -1;
            best[1] = -1;
            best[2] = 200;
        }

        if(depth == 0 || is_game_over(state)){
            score2 = evaluate(state);
            int[] array = {-1, -1, score2};
            return array;
        }

        int[][] cells = list_of_empty_cells(state);
        for (int i = 0; i < cells.length; i++) {
            x = cells[i][0];
            y = cells[i][1];
            state[x][y] = player;
            score = minimax(state, depth - 1, 0 - player);
            state[x][y] = 0;
            score[0] = x;
            score[1] = y;
            if(player == COMP){
                if(score[2] > best[2]){
                    best[0] = score[0];
                    best[1] = score[1];
                    best[2] = score[2];
                }
            }
            else{
                if(score[2] < best[2]){
                    best[0] = score[0];
                    best[1] = score[1];
                    best[2] = score[2];
                }
            }
        }

        return best;
    }

    public void render(int[][] state, char c_choice, char h_choice){
        System.out.println("----------------");
        for (int i = 0; i < state.length; i++) {
            System.out.println("\n----------------");
            for (int j= 0; j < state[i].length; j++) {
                if(state[i][j] == +1)
                    System.out.print("|" + c_choice + "|");
                else if(state[i][j] == -1)
                    System.out.print("|" + h_choice + "|");
                else
                    System.out.print("| |");
            }
        }
        System.out.println("\n----------------");
    }

    public void ai_turn(char c_choice, char h_choice){
        int depth = list_of_empty_cells(board).length;
        int x, y;

        if(depth == 0 || is_game_over(board))
            return;
        
        // System.out.println("Comuter's turn [" + c_choice + "]");
        render(board, c_choice, h_choice);

        // if(depth == 9){
        //     int[] array = {0, 1, 2};
        //     x = new Random().nextInt(array.length);
        //     y =  new Random().nextInt(array.length);
        // }
        // else{
            int[] move = minimax(board, depth, COMP);
            x = move[0];
            y = move[1];
        //}

        set_move(x, y, COMP);
        try 
        {
            Thread.sleep(2000);
        } 
        catch(InterruptedException e)
        {
            // this part is executed when an exception (in this example InterruptedException) occurs
        }
    }

    public void human_turn(char c_choice, char h_choice) throws IOException{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int depth = list_of_empty_cells(board).length;
        if(depth == 0 || is_game_over(board)){
            return;
        }

        int move = -1;
        render(board, c_choice, h_choice);

        int x, y;
        while(move < 1 || move > 9){
            x = -1;
            y = -1;
            System.out.print("Human's turn [" + h_choice + "] - Where do you want to play? : ");
            move = Integer.parseInt(br.readLine());
            if(move == 1){
                x = 0;
                y = 0;
            }
            else if(move == 2){
                x = 0;
                y = 1;
            }
            else if(move == 3){
                x = 0;
                y = 2;
            }
            else if(move == 4){
                x = 1;
                y = 0;
            }
            else if(move == 5){
                x = 1;
                y = 1;
            }
            else if(move == 6){
                x = 1;
                y = 2;
            }
            else if(move == 7){
                x = 2;
                y = 0;
            }
            else if(move == 8){
                x = 2;
                y = 1;
            }
            else if(move == 9){
                x = 2;
                y = 2;
            }
            else {
                System.out.println("Bad move");
            }
            if(x != -1 && y != -1){
                boolean try_move = set_move(x, y, HUMAN);

                if(try_move == false){
                    System.out.println("Bad move");
                    move = -1;
                }
            }
        }
    }

    public void run() throws IOException{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        char h_choice = 'X';
        char c_choice = 'O';

        System.out.println("Do you want to start? (Y/N)");
        char first = Character.toUpperCase((char)br.read());

        if(first == 'N'){
            ai_turn(c_choice, h_choice);
        }

        while(list_of_empty_cells(board).length > 0 && is_game_over(board) == false){
            human_turn(c_choice, h_choice);
            ai_turn(c_choice, h_choice);
        }

        render(board, c_choice, h_choice);
        if(wins(board, HUMAN)){
            System.out.println("You win");
        }
        else if(wins(board, COMP)){
            System.out.println("Computer wins");
        }
        else{
            System.out.println("Its a draw!");
        }
    }

    public static void main(String args[]) throws IOException{
        TicTacToe t = new TicTacToe();
        t.run();
    }
}