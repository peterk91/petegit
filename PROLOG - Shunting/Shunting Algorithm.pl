% Peter Krepa
% A913724
% Shunting Alogrithm - Prolog

bracket('(').
bracket(')').
operator(+).
operator(-).
operator(*).
operator(/).

shunt(Input,Output):-													% calls shuntSort with the input list and an empty buffer list.
	bracketCheck(Input,0,0),
	shuntSort(Input,[],Output).

bracketCheck([],Count1,Count2):-										% checks there are an equal number of opening and closing brackets
	Count1=Count2;
	(Count1 > Count2, write('There is one or more close bracket(s) missing'));
	(Count1 < Count2, write('There is one or more open bracket(s) missing')).
	
bracketCheck([Head|Tail],Count1,Count2):-
	(Head = '(',
	NewCount1 is Count1+1,
	bracketCheck(Tail,NewCount1,Count2));
	(Head = ')',
	NewCount2 is Count2+1,
	bracketCheck(Tail,Count1,NewCount2));
	(\+ Head = '(',
	\+ Head = ')',
	bracketCheck(Tail,Count1,Count2)).

shuntSort([],[],[]).													% Input list is empty. Buffer is empty. RESULT - end of program

shuntSort([],[BufferOp|Buffer],[BufferOp|Output]):- 					% Input list is empty. Buffer is not empty. RESULT - item from buffer is moved to output.
	\+ BufferOp = '(',
	shuntSort([],Buffer,Output).

shuntSort([InputInt|Tail],Buffer,[InputInt|Output]):-					% Head of input list is an integer. RESULT - integer moved to output.
	\+ operator(InputInt),
	\+ bracket(InputInt),
	shuntSort(Tail,Buffer,Output).
	
shuntSort([InputOp|Tail],[],Output):-									% Head of input list is an operator. Buffer is empty. RESULT - operator moved into buffer.
	operator(InputOp),
	shuntSort(Tail,[InputOp],Output).

shuntSort([InputOp|Tail],[BufferOp|Buffer],[BufferOp|Output]):-			% Head of input list is an operator. Head of buffer is an operator. BufferOp is precedent. RESULT - BufferOp moved to output .
	operator(InputOp),
	current_op(Inputpre,yfx,InputOp),
	current_op(Bufferpre,yfx,BufferOp),
	Bufferpre @=< Inputpre,
	shuntSort([InputOp|Tail],Buffer,Output).
	
shuntSort([InputOp|Tail],[BufferOp|Buffer],Output):-					% Head of input list is an operator. Head of buffer is an operator. InputOp precedent. RESULT - InputOp moved to head of buffer.
	operator(InputOp),
	current_op(Inputpre,yfx,InputOp),
	current_op(Bufferpre,yfx,BufferOp),
	Bufferpre @> Inputpre,
	shuntSort(Tail,[InputOp,BufferOp|Buffer],Output).

shuntSort(['('|Tail],Buffer,Output):-									% Head of input list is an open bracket. RESULT - open bracket moved to head of buffer.
	shuntSort(Tail,['('|Buffer],Output).
	
shuntSort([InputOp|Tail],['('|Buffer],Output):-							% Head of input list is an operator. Head of buffer is an open bracket. RESULT - operator moved to head of buffer.
	operator(InputOp),
	shuntSort(Tail,[InputOp,'('|Buffer],Output).
	
shuntSort([')'|Tail],[BufferOp|Buffer],[BufferOp|Output]):-				% Head of input list is a close bracket. Head of buffer is an operator. RESULT - BufferOp moved to output.
	operator(BufferOp),
	shuntSort([')'|Tail],Buffer,Output).
	
shuntSort([')'|Tail],['('|Buffer],Output):-								% Head of input list is a close bracket. Head of buffer is an open bracket. RESULT continue program discarding the set of brackets
	shuntSort(Tail,Buffer,Output).