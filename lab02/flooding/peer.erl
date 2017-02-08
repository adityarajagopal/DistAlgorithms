-module(peer).
-export([start/0]).

start()->
  C = spawn(counter,start,[]),
  broadcast(C).

broadcast(C)->
  receive
    {msg,Msg,Peers} -> 
      Counter = counter:tick(C),
      if
        Counter =< 1 ->
          io:format('Peer ~p has recieved message ~p ~n',[self(),Msg]),
          [P ! {msg,Msg,[[self()]|lists:delete(P,Peers)]} || P <- Peers];
        true -> false
      end
  after
    1000 -> 
      io:format("Peer ~p Messages seen = ~p ~n",[self(),counter:tick(C)-1])
  end,
  broadcast(C).
