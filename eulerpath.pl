connected(A, B) :- edge(A, B); edge(B, A).

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