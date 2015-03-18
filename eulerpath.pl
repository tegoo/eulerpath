
connected(A, B) :- edge(A, B); edge(B, A).

allNodes(Nodes) :- 
	findall(N, node(N), Nodes).

allEdges(Edges) :- 
	findall([A, B], edge(A, B), Edges).


used([Node1, Node2], Path) :- 
		member([Node1, Node2], Path);
		member([Node2, Node1], Path).

allUsed([], _) :- true.

allUsed([Edge | Edges], Path) :-
	used(Edge, Path),
	allUsed(Edges, Path).

follows([[_, CurrentNode]|_], [CurrentNode, NodeTo]) :- 
	connected(CurrentNode, NodeTo).

eulerpath([], Result) :- 
	connected(CurrentNode, NodeTo), 
	eulerpath([[CurrentNode, NodeTo]], Result).

eulerpath(Path, Result) :- 
	follows(Path, Edge),
	not(used(Edge, Path)),
	eulerpath([Edge | Path], Result).

eulerpath(Path, Result) :-
	is_list(Path), 
	allEdges(Edges),
	allUsed(Edges, Path),
	reverse(Path, Result).

eulerpath(Result) :-
	eulerpath(_, Result).


path(A,B,Path) :-
    	path(A,B,[A],Q), 
    	reverse(Q,Path).

path(A,B,P,[B|P]) :- 
    	connected(A,B).

path(A,B,Visited,Path) :-
    	connected(A,C),           
    	C \== B,
    	not(member(C,Visited)),
    	path(C,B,[C|Visited],Path).

isSubset([],_).
isSubset([H|T],Y):-
		member(H,Y),
    	select(H,Y,Z),
    	isSubset(T,Z).
equalLists(X,Y):-
		isSubset(X,Y),
		isSubset(Y,X).