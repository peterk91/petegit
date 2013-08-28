:- op(800,xfy,--->).
:- op(800,xfy,<---).

topsort(Nodes,Edges,Outlist):-
	sortArrows(Edges,NewEdges),						
	checkEdge(NewEdges,Nodes),
	startSort(Nodes,NewEdges,Outlist).
	
startSort([],[],[]).
startSort(Nodes,Edges,[X|Tail]):-
	usable(Nodes,Edges,X),							
	delete(Nodes,X,NewNodes),						
	delete(Edges,X--->_,NewEdges),				
	startSort(NewNodes,NewEdges,Tail).				

usable(Nodes,Edges,X):- 					 
	member(X,Nodes),
	\+ unUsable(Edges,X).						

unUsable([_--->X|_],X).								
unUsable([_--->_|Tail],Y):- 						
	unUsable(Tail,Y).

sortArrows([],[]).
sortArrows([A--->B--->C|Bottom],[X|Rest]):- !,		
	X= (A--->B),
	sortArrows([B--->C|Bottom],Rest).
sortArrows([A<--- B<--- C|Bottom],[X|Rest]):- !,	
	X= (B--->A),
	sortArrows([B<--- C|Bottom],Rest).
sortArrows([A--->B|Y],[X|Rest]):- !,				
	[X|Y] = [A--->B|Y],
	sortArrows(Y,Rest).
sortArrows([Y<---X|Tail] ,[X--->Y|Rest]):-			
	sortArrows(Tail,Rest).

checkEdge([],_).
checkEdge([A--->B|Tail],Nodes):-
	A \= B,
	member(A,Nodes),
	member(B,Nodes),
	checkEdge(Tail,Nodes).
