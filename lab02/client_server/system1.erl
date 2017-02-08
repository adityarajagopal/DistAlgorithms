
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system1).
-export([start/1]).
 
start([N|T]) ->  
  % spawn a server node with server id S
  S  = spawn(server, next, []),
 
  % list of clients, uses list comprehension to generate a list of clients based on N
  % uses another list comprehension to send messages to the server to bind  
  %%Clients = [spawn(client,start,[]) || List_iterator <- lists:seq(1,list_to_integer(atom_to_list(N)))],
  %%[C ! {bind,S,C} || C <- Clients].
 
  % Even more optimised version of the list comprehension done above 
  [C ! {bind,S,C} || C <-[spawn(client,start,[]) || List_iterator <- lists:seq(1,list_to_integer(atom_to_list(N)))]].
  
  % arguments from the shell are passed into start as a list of atoms
  % this is why we need to convert from atom to list to integer
  %%generate_clients(list_to_integer(atom_to_list(N)),Clients,S).


generate_clients(0,Acc,S)->Acc;
generate_clients(N,Acc,S)->
  L = spawn(client,start,[]), 
  %send message to L saying that server S wants to bind with it
  %also pass the client id (L) to the client 
  L ! {bind, S, L},
  %accumulate clients in Acc list and return this at the base case
  generate_clients(N-1,[L|Acc],S).


