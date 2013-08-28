bracket('(').
bracket(')').
operator(+).
operator(-).
operator(*).
operator(/).

shunt(Input,Output):-
	bracketCheck(Input,0,0),
	shuntSort(Input,[],Output).

bracketCheck([],Count1,Count2):-
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

shuntSort([],[],[]).


shuntSort([],[BufferOp|Buffer],[BufferOp|Output]):-
	\+ BufferOp = '(',
	shuntSort([],Buffer,Output).

shuntSort([InputInt|Tail],Buffer,[InputInt|Output]):-
	\+ operator(InputInt),
	\+ bracket(InputInt),
	shuntSort(Tail,Buffer,Output).
	
shuntSort([InputOp|Tail],[],Output):-
	operator(InputOp),
	shuntSort(Tail,[InputOp],Output).

shuntSort([InputOp|Tail],[BufferOp|Buffer],[BufferOp|Output]):-
	operator(InputOp),
	current_op(Inputpre,yfx,InputOp),
	current_op(Bufferpre,yfx,BufferOp),
	Bufferpre @=< Inputpre,
	shuntSort([InputOp|Tail],Buffer,Output).
	
shuntSort([InputOp|Tail],[BufferOp|Buffer],Output):-
	operator(InputOp),
	current_op(Inputpre,yfx,InputOp),
	current_op(Bufferpre,yfx,BufferOp),
	Bufferpre @> Inputpre,
	shuntSort(Tail,[InputOp,BufferOp|Buffer],Output).

shuntSort(['('|Tail],Buffer,Output):-
	shuntSort(Tail,['('|Buffer],Output).
	
shuntSort([InputOp|Tail],['('|Buffer],Output):-
	operator(InputOp),
	shuntSort(Tail,[InputOp,'('|Buffer],Output).
	
shuntSort([')'|Tail],[BufferOp|Buffer],[BufferOp|Output]):-
	operator(BufferOp),
	shuntSort([')'|Tail],Buffer,Output).
	
shuntSort([')'|Tail],['('|Buffer],Output):-
	shuntSort(Tail,Buffer,Output).