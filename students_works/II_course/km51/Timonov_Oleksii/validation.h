void SetColor(int text, int background) {
   
   HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
   SetConsoleTextAttribute(hStdOut, (WORD)((background << 4) | text));
}

void gotoxy(int x, int y) {
  static HANDLE h = NULL;  
  if(!h)
    h = GetStdHandle(STD_OUTPUT_HANDLE);
  COORD c = { x, y };  
  SetConsoleCursorPosition(h,c);
}

char user_wait(char line[], int x, int y){
	int length = strlen(line);
	int i;
	
	SetColor(12,0);
	
	gotoxy(x,y);
	printf("%s", line);
	
	while(!kbhit());
	
	gotoxy(x,y);
	for(i=0; i<length; i++)
		printf(" ");
	
	SetColor(7,0);
	
	return getch();
}

float get_float(int position_x, int position_y, int MAX_LENGTH){
	struct Stack * digit_stack = malloc(sizeof(struct Stack));
	digit_stack->head = NULL;
	
	int user_input = 0;
	int previous = 0;
	int i = 0;
	int stack_receive = 0;
	int content[100];
	int amount = 0;
	int window_x = position_x;
	int e_mark = 0, comma_mark = 0;
	int error_code = 0;
	
	gotoxy(position_x, position_y);
	
	do {
		gotoxy(window_x + amount, position_y);
		user_input = getch();
		
		error_code = 0;
		
		if(amount == 0) previous = 0; 
		if(amount == MAX_LENGTH) error_code = 1;
		
		switch(user_input){
			case 8: {						// backspace
				stack_receive = Pop(digit_stack);
				previous = Pop(digit_stack);
				Push(previous, digit_stack);
				if(stack_receive == 44) {
			 	    comma_mark = 0;
			 	}
				if(stack_receive == 101){
			        e_mark = 0;
				}
				
				error_code = 0;
				break;
			}			
						
			case 45:{						// decreasing
				
				if(previous!=101 && previous!=0) error_code = 4;
				
				if(amount<MAX_LENGTH && (previous==0 || previous == 101)){
					Push(user_input, digit_stack);
					previous = user_input;
				} 
				break;
			}
			
			case 44:{						// comma
				
				if(comma_mark!=0 || previous==101 || previous==0) error_code = 3;
				
				if(amount<MAX_LENGTH && previous!=0 && comma_mark == 0 && previous!=101){
					Push(user_input, digit_stack);
					comma_mark = 1;
					previous = user_input;
				} 
				
				break;
			}
			
			case 101:{						// e symbol
			
				if(comma_mark!=1 || e_mark!=0 || previous==44) error_code = 2;
		
				if(amount<MAX_LENGTH && comma_mark==1 && previous!=44 && e_mark == 0){
					Push(user_input, digit_stack);
					e_mark = 1;
					previous = user_input;
				} 
				
				break;
			}
			
			case 13: {						// enter
				error_code = 0; 
				break;
			}
		
			default: {
				if(user_input>=48 && user_input<=57 && amount<MAX_LENGTH){
					Push(user_input, digit_stack);	
					previous = user_input;
					break;
				} 
				if(error_code!=1)
					error_code = 5; 
				break;
			}	
		
		}
		
		switch(error_code){
			case 1: user_wait("Too many digits!", window_x + 25, position_y); break;
			case 2: user_wait("Invalid place for 'e'!", window_x + 25, position_y); break;
			case 3: user_wait("Invalid place for ','!", window_x + 25, position_y); break;
			case 4: user_wait("Invalid place for '-'!", window_x + 25, position_y); break;
			case 5: user_wait("Invalid symbol!", window_x + 25, position_y); break;	
		}
		
		gotoxy(window_x, position_y);
		
		amount = Show_Stack(&content[0], digit_stack);
		
		for(i=0; i<amount; i++){
			printf("%c", content[amount-i-1]);
		}
		
		printf(" ");
			
	} while(user_input!=13 || amount == 0);
	
	char result[100];
	
	for(i=0; i<amount; i++){
		char temp = content[amount-i-1];
		result[i] = temp;
	}
	
	result[amount] = '\0';
	
	return atof(result);
}

int get_string(char * result_content, int position_x, int position_y, int MAX_LENGTH){
	struct Stack * string_stack = malloc(sizeof(struct Stack));
	string_stack->head = NULL;
	
	int user_input = 0;
	int previous = 0;
	int stack_receive = 0;
	int content[100];
	int i = 0;
	int amount = 0;
	int window_x = position_x;
	int error_code = 0;
	
	do{
		gotoxy(window_x + amount, position_y);
		user_input = getch();
		
		error_code = 0;
		
		if(amount == 0) previous = 0; 
		if(amount == MAX_LENGTH) error_code = 1;
		
		if(amount<MAX_LENGTH && ((user_input>64 && user_input<91) || (user_input>96 && user_input<123))){
			Push(user_input, string_stack);
			previous = user_input;
		} else if(user_input == 8){
			stack_receive = Pop(string_stack);
			previous = Pop(string_stack);
			Push(previous, string_stack);
			error_code = 0;
		} else if(user_input == 32){
			if(previous != 32){
				Push(user_input, string_stack);
				previous = 32;
			} else {
				error_code = 3;
			}
		} else if(amount >= MAX_LENGTH) {
			error_code = 1;
		} else if(user_input == 13){
			error_code = 0;
		} else {
			error_code = 2;
		}
		
		switch(error_code){
			case 1: user_wait("Too many symbols!", window_x + 25, position_y); break;
			case 2: user_wait("Invalid symbol!", window_x + 25, position_y); break;
			case 3: user_wait("Too many spaces!", window_x + 25, position_y); break;
		}
		
		gotoxy(window_x, position_y);
		
		amount = Show_Stack(&content[0], string_stack);
		
		for(i=0; i<amount; i++){
			printf("%c", content[amount-i-1]);
		}
		
		printf(" ");
		
	} while(user_input != 13 || amount == 0);
	
	amount = Show_Stack(&content[0], string_stack);
	
	for(i=0; i<amount; i++)
		*(result_content+i) = (char) content[amount-i-1];
	
	*(result_content+amount) = (char) '\0';
	
	return amount;
}

int get_group(char * result_content, int position_x, int position_y){
	int user_input = 0;
	int amount = 0;
	int content[20];
	int i=0;
	
	struct Stack * group_stack = (struct Stack *) malloc(sizeof(struct Stack)); 
	group_stack->head = NULL;
	
	gotoxy(position_x, position_y);
	printf("     ");
	gotoxy(position_x, position_y);
	
	do{
		user_input = getch();
		
		if(amount==0 || amount==1){
			if(user_input>64 && user_input<91)
				Push(user_input, group_stack);
			if(user_input>96 && user_input<123)
				Push(user_input-32, group_stack);
		}
		if(amount==2){
			Push(95, group_stack);
		}
		if(amount==3 || amount==4){
			if(user_input>47 && user_input<58)
				Push(user_input, group_stack);
		}
		if(user_input == 8){
			if(Pop(group_stack) == 95)
				Pop(group_stack);
		}
		
		amount = Show_Stack(&content[0], group_stack);
	
		gotoxy(position_x, position_y);
		
		for(i=0; i<amount; i++)
			printf("%c", content[amount-i-1]);
			
		printf(" ");	
	
	}while(amount!=5);
	
	amount = Show_Stack(&content[0], group_stack);
	
	for(i=0; i<amount; i++)
		*(result_content + i) = (char) content[amount-i-1];
	
	*(result_content + amount) = (char) '\0';
	
	return amount;
}

int get_date(char * result_content, int position_x, int position_y){
	int user_input = 0;
	int amount = 0;
	int content[10];
	int i = 0;
	int error_code;
	
	struct Stack * date_stack = (struct Stack *) malloc(sizeof(struct Stack)); 
	date_stack->head = NULL;
	
	gotoxy(position_x, position_y);
	printf("Date(DD/MM/YYYY): ");
	position_x += 18;
	
	do{
		error_code = 0;
		user_input = getch();
		
		if(amount == 0)
			if(user_input>=48 && user_input <=51)
				Push(user_input, date_stack);
			else
				error_code = 1;
			
		if(amount == 1){
			gotoxy(5,6);
			if(Show_Head(date_stack) == 51 && (user_input ==48 || user_input == 49)){
				Push(user_input, date_stack);
				Push(47, date_stack);
			} else if(Show_Head(date_stack) == 48 && user_input >=49 && user_input <=57) {
				Push(user_input, date_stack);
				Push(47, date_stack);
			} else if(Show_Head(date_stack) != 51 && Show_Head(date_stack) != 48 && user_input >=48 && user_input <=57){
				Push(user_input, date_stack);
				Push(47, date_stack);
			} else {
				error_code = 1;
			}
		}
		
		if(amount == 3)
			if(user_input==48 || user_input ==49)
				Push(user_input, date_stack);
			else
				error_code = 2;
			
		if(amount == 4){
			gotoxy(5,6);
			if(Show_Head(date_stack) == 48 && (user_input >= 49 && user_input <= 57)){
				Push(user_input, date_stack);
				Push(47, date_stack);
			} else if(Show_Head(date_stack) == 49 && (user_input >=48 && user_input <=50)) {
				Push(user_input, date_stack);
				Push(47, date_stack);
			} else {
				error_code = 2;
			}
		}
		
		if(amount == 6)
			if(user_input == 50)
				Push(user_input, date_stack);
			else
				error_code = 3;
		
		if(amount > 6)
			if(user_input >=48 && user_input <= 57)
				Push(user_input, date_stack);
		
		switch(error_code){
			case 1:{
				user_wait("Oops. We have only 31 days in month.", position_x + 20, position_y);
				break;
			}
			case 2:{
				user_wait("Oops. We have only 12 months.", position_x + 20, position_y);
				break;
			}
			case 3:{
				user_wait("Come on! We live in second millenium!", position_x + 20, position_y);
				break;
			}
		}
		
		if(user_input == 8)
			Pop(date_stack);
		else if(amount == 2 || amount == 5)
			Push(47, date_stack);
		
		amount = Show_Stack(&content[0], date_stack);
		gotoxy(position_x, position_y);
		
		for(i=0; i<amount; i++)
			printf("%c", content[amount-i-1]);
		printf(" ");
			
	}while(amount != 10);
	
	amount = Show_Stack(&content[0], date_stack);
	
	for(i=0; i<amount; i++)
		*(result_content + i) = (char) content[amount-i-1];
	
	*(result_content + amount) = (char) '\0';
	
	return amount;
}

int get_int(int position_x, int position_y, int length){
	int user_input = 0;
	int amount = 0;
	int content[20];
	int i = 0;
	int error_code;
	char result_content[20];
	
	struct Stack * int_stack = (struct Stack *) malloc(sizeof(struct Stack)); 
	int_stack->head = NULL;
	
	gotoxy(position_x, position_y);
	printf("Amount: ");
	position_x += 8;
	
	do{
		error_code = 0;
		user_input = getch();
		
		if(user_input >=48 && user_input <=57 && amount < length){
			Push(user_input, int_stack);
		} else if(amount == length)
			error_code = 1;
		else if(user_input != 13)
			error_code = 2; 
		
		if(user_input == 13)
			error_code = 0;
			
		switch(error_code){
			case 1:{
				user_wait("Too many digits.", position_x + 20, position_y);
				break;
			}
			case 2:{
				user_wait("Invalid symbol", position_x + 20, position_y);
				break;
			}
		}
		
		if(user_input == 8)
			Pop(int_stack);
		
		amount = Show_Stack(&content[0], int_stack);
		gotoxy(position_x, position_y);
		
		for(i=0; i<amount; i++)
			printf("%c", content[amount-i-1]);
			
		printf(" ");
			
	}while(user_input != 13 || amount == 0);
	
	amount = Show_Stack(&content[0], int_stack);
	
	for(i=0; i<amount; i++)
		*(result_content + i) = (char) content[amount-i-1];
	
	*(result_content + amount) = (char) '\0';
	
	return atoi(result_content);
}
