
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system1).
-export([start/1]).
 
start([N|T]) ->  
 %%% C1 = spawn(client, start, []),
 %%% C2 = spawn(client, start, []), 
  S  = spawn(server, next, []),
 
  Clients = [], 
  generate_clients(list_to_integer(atom_to_list(N)),Clients,S).

generate_clients(0,Acc,S)->Acc;
generate_clients(N,Acc,S)->
  L = spawn(client,start,[]), 
  L ! {bind, S, L},
  generate_clients(N-1,[L|Acc],S).


