node(a).
node(b).
node(c).
node(d).

edge(a, b).
edge(a, c).
edge(b, c).
edge(b, d).

edge(A, B) :- edge(B, A).

walk(Node, Visited) :- 
		write(Node), nl,
		edge(Node, Neighbor),
		(not(member(Node, Visited)),
		append(Visited, [Node], Visited1),
		printlist(Visited1), print('\n'),
		walk(Neighbor, Visited1)); true.

walk(Node) :- walk(Node, []).

printlist(X) :- write(X).
printlist([]) :- write('list: ').
printlist([X|List]) :-
    	printlist(List),
    	write(X).

