
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system1).
-export([start/1]).
 
start([N|T]) ->  
  % spawn N peers and pass to each peer the message 'hello' and a list of all of its neighbours
  Peers = [spawn(peer,start,[]) || List_iterator <- lists:seq(1,list_to_integer(atom_to_list(N)))],
  
  [  || i <- lists:seq(1,list_to_integer(atom_to_list(N)]

neighbours(Peers,1,[2,7]),
neighbours(Peers,2,[1,3,4]),
neighbours(Peers,3,[2,4,5]),
neighbours(Peers,4,[2,3,6]),
neighbours(Peers,5,[3]),
neighbours(Peers,6,[4]),
neighbours(Peers,7,[1,8]),
neighbours(Peers,8,[7,9,10]),
neighbours(Peers,9,[8,10]),
neighbours(Peers,10,[8,9]).

