-module(peer3).
-export([start/0]).

start()->
  C = spawn(counter,start,[]),
  Par = spawn(parent,start,[]),
  broadcast(C,Par).

broadcast(C,Par)->
  receive
    {init,Msg,Peers} -> 
      io:format('Peer ~p has recieved peers ~p ~n',[self(),Peers]),
      [P ! {msg,Msg,self()} || P <- Peers];
    {msg,Msg,Parent} -> 
      Counter = counter:tick(C),
      if
        Counter =< 1 ->
          io:format('Peer ~p has recieved message from peer ~p ~n',[self(),Parent]),
          parent:set_parent(Par,Parent);
        true -> false
      end
  after
    1000 -> 
      io:format("Peer ~p Parent ~p Messages seen = ~p ~n",[self(),parent:get_parent(Par),counter:read(C)])
  end,
  broadcast(C,Par).

