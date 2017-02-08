%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system2).
-export([start/1]).
 
start([N|T]) ->  
  % spawn N peers and pass to each peer the message 'hello' and a list of all of its neighbours
  Peers = [{neighbours(List_iterator),spawn(peer,start,[])} || List_iterator <- lists:seq(1,list_to_integer(atom_to_list(N)))],
  [P ! {init,'hello',[S || {I,S} <- [lists:nth(I,Peers) || I<-S]]} || {S,P} <- Peers].
  

neighbours(1) -> [2,7];
neighbours(2) -> [1,3,4];
neighbours(3) -> [2,4,5];
neighbours(4) -> [2,3,6];
neighbours(5) -> [3];
neighbours(6) -> [4];
neighbours(7) -> [1,8];
neighbours(8) -> [7,9,10];
neighbours(9) -> [8,10];
neighbours(10) ->[8,9].

