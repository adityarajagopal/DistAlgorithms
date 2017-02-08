
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system1).
-export([start/1]).
 
start([N|T]) ->  
  % spawn N peers and pass to each peer the message 'hello' and a list of all of its neighbours
  Peers = [spawn(peer,start,[]) || List_iterator <- lists:seq(1,list_to_integer(atom_to_list(N)))],
  [P ! {init,'hello',lists:delete(P,Peers)} || P <- Peers].


