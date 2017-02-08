-module(peer).
-export([start/0]).

start()->
  C = spawn(counter,start,[]),
  broadcast(C).

broadcast(C)->
  receive
    {init,Msg,Peers} -> 
      Counter = counter:tick(C),
      if
        Counter =< 1 ->
          io:format('Peer ~p has recieved peers ~p ~n',[self(),Peers]),
          [P ! {msg,Msg} || P <- Peers];
        true -> false
      end;
    {msg,Msg} -> 
      Counter = counter:tick(C),
      if
        Counter =< 1 ->
          io:format('Peer ~p has recieved message from peer ~n',[self()]);
        true -> false
      end
  after
    1000 -> 
      io:format("Peer ~p Messages seen = ~p ~n",[self(),counter:read(C)])
  end,
  broadcast(C).
