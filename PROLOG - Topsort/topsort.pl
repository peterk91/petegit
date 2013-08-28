% Peter Krepa - A913724

:- op(800,xfy,--->).
:- op(800,xfy,<---).

topsort(Nodes,Edges,Outlist):-
	sortArrows(Edges,NewEdges),						% turns arrows into one direction, and also splits up chains into separate rules
	checkEdge(NewEdges,Nodes),
	startSort(Nodes,NewEdges,Outlist).
	
startSort([],[],[]).
startSort(Nodes,Edges,[X|Tail]):-
	usable(Nodes,Edges,X),							% finds a nodes with indegree of 0
	delete(Nodes,X,NewNodes),						% deletes this node from the nodes list
	delete(Edges,X--->_,NewEdges),					% deletes any edges which this node is present on the entry side
	startSort(NewNodes,NewEdges,Tail).				% recurses with the new edge and node list

usable(Nodes,Edges,X):- 					 
	member(X,Nodes),
	\+ unUsable(Edges,X).							% finds all nodes with an indegree > 0, and does not use them

unUsable([_--->X|_],X).								% identifies that a the current node is the end of an edge, so it passes
unUsable([_--->_|Tail],Y):- 						% if the edge does not contain the node it will process the rest of the list
	unUsable(Tail,Y).

sortArrows([],[]).
sortArrows([A--->B--->C|Bottom],[X|Rest]):- !,		% identifies a chain and retrieves the first rule from the chain
	X= (A--->B),
	sortArrows([B--->C|Bottom],Rest).
sortArrows([A<--- B<--- C|Bottom],[X|Rest]):- !,	% identifies a chain in the other direction
	X= (B--->A),
	sortArrows([B<--- C|Bottom],Rest).
sortArrows([A--->B|Y],[X|Rest]):- !,				% carries on working if the arrow is in standard format ie A--->B
	[X|Y] = [A--->B|Y],
	sortArrows(Y,Rest).
sortArrows([Y<---X|Tail] ,[X--->Y|Rest]):-			% switches an arrow into the standard format
	sortArrows(Tail,Rest).

checkEdge([],_).									% checks for user errors in the edges list
checkEdge([A--->B|Tail],Nodes):-
	A \= B,
	member(A,Nodes),
	member(B,Nodes),
	checkEdge(Tail,Nodes).
