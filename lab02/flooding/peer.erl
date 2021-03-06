-module(peer).
-export([start/0]).

start()->
  broadcast(0).

broadcast(C)->
  receive
    {init,Msg,Peers} -> 
      if
        C < 1 ->
          io:format('Peer ~p has recieved peers ~p ~n',[self(),Peers]),
          [P ! {msg,Msg} || P <- Peers];
        true -> false
      end,
      broadcast(C+1);
    {msg,Msg} -> 
      if
        C < 1 ->
          io:format('Peer ~p has recieved message from peer ~n',[self()]);
        true -> false
      end,
	  broadcast(C+1)
  after
    1000 -> 
      io:format("Peer ~p Messages seen = ~p ~n",[self(),C])
  end.
