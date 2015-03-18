#!/usr/bin/prolog -f

:- set_prolog_flag(verbose, silent).

:- initialization main.

main :-
        process,
        halt.
main :-
        halt(1).

node(a).
node(b).
node(c).
node(d).
node(e).

edge(a, b).
edge(a, c).
edge(a, d).
edge(c, b).
edge(c, d).
edge(c, e).
edge(d, e).
edge(d, b).

isSubset([],_).
isSubset([H|T],Y):-
		member(H,Y),
    	select(H,Y,Z),
    	isSubset(T,Z).
equalLists(X,Y):-
		isSubset(X,Y),
		isSubset(Y,X).

allNodes(Nodes) :- 
	findall(N, node(N), Nodes).

allEdges(Edges) :- 
	findall([A, B], edge(A, B), Edges).

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

process :- 
	eulerpath(Result),
	open('result.txt',write,Stream), 
    write(Stream, Result), nl(Stream), 
    close(Stream).


connected(A, B) :- edge(A, B); edge(B, A).

used([Node1, Node2], Path) :- 
		member([Node1, Node2], Path);
		member([Node2, Node1], Path).

allUsed([], _) :- true.

allUsed([Edge | Edges], Path) :-
	used(Edge, Path),
	allUsed(Edges, Path).


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
