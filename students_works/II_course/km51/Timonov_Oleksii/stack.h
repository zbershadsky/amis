struct Item{
	int value;
	struct Item * next;
};

struct Stack{
	struct Item * head;
};

void Push(int value, struct Stack * user_stack){
	struct Item * temp = (struct Item *) malloc(sizeof(struct Item));
	temp->next = user_stack->head;				
	user_stack->head = temp;					
	user_stack->head->value = value;			
}

int Pop(struct Stack * user_stack){	
	int value = 0;
	if(user_stack->head != NULL){
		value = user_stack->head->value;		
		struct Item * temp = user_stack->head;				
		user_stack->head = user_stack->head->next;
		free(temp);
	}
	return value;					
}

int Stack_Length(struct Stack * user_stack){
	int length = 0;
	
	while(user_stack->head!=NULL){
		user_stack->head = user_stack->head->next;
		length++;
	}
	
	return length;
}

int Show_Stack(int * content, struct Stack * user_stack){
	struct Item * pseudo_head = user_stack->head;
	int amount = 0;
	
	while(pseudo_head != NULL){
		*(content+amount) = pseudo_head->value;
		pseudo_head = pseudo_head->next;
		amount++;
	}
	free(pseudo_head);
	
	return amount;
}

int Show_Head(struct Stack * user_stack){
	int content = Pop(user_stack);
	Push(content, user_stack);
	
	return content;
}
