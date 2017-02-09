-module(peer5).
-export([start/0]).

start()->
  broadcast(0,0,0).

broadcast(C,C_child,Par)->
  receive
    {init,Msg,Peers} -> 
      io:format('Peer ~p has recieved peers ~p ~n',[self(),Peers]),
      [P ! {msg,Msg,self()} || P <- Peers],
	  broadcast(C,C_child,Par);
    {msg,Msg,Parent} -> 
      if
        C < 1 ->
		  Parent ! {child,rand:uniform(10)}, 
	      broadcast(C+1,C_child,Parent);
        true -> broadcast(C+1,C_child,Par)
      end;
	{child,Value} -> 
      broadcast(C,C_child+Value,Par)	
  after
    1000 -> 
      io:format("Peer ~p Parent ~p Children = ~p ~n",[self(),Par,C_child])
  end.

