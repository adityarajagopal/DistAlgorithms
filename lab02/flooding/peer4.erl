-module(peer4).
-export([start/0]).

start()->
  C = spawn(counter,start,[]),
  C_child = spawn(counter,start,[]),
  Par = spawn(parent,start,[]),
  broadcast(C,C_child,Par).

broadcast(C,C_child,Par)->
  receive
    {init,Msg,Peers} -> 
      io:format('Peer ~p has recieved peers ~p ~n',[self(),Peers]),
      [P ! {msg,Msg,self()} || P <- Peers];
    {msg,Msg,Parent} -> 
      Counter = counter:tick(C),
      if
        Counter =< 1 ->
          %io:format('Peer ~p has recieved message from peer ~p ~n',[self(),Parent]),
		  Parent ! {child}, 
          parent:set_parent(Par,Parent);
        true -> false
      end;
	{child} -> 
	  counter:tick(C_child)
	
  after
    1000 -> 
      io:format("Peer ~p Parent ~p Children = ~p ~n",[self(),parent:get_parent(Par),counter:read(C_child)])
  end,
  broadcast(C,C_child,Par).

