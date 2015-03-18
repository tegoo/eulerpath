#!/usr/bin/prolog -q -f

:- initialization main.

main :-
	consult('eulerpath.pl'),
	consult('database.pl'),
    process,
    halt.
main :-
    halt(1).


process :- 
	findall(Path, eulerpath(Path), Paths),
	write(Paths).