-module(counter).
-export([start/0,tick/1,read/1,acc/2]).

start()->
  state(0).

tick(Counter)->
  Counter ! {tick,self()},
  receive 
    {state,S} -> S
  end.

read(Counter)->
  Counter ! {read,self()},
  receive
    {state,S} -> S
  end.
 
acc(Counter,Value)->
  Counter ! {acc,self(),Value},
  receive 
    {state,S} -> S
  end.

state(State)->
  receive 
    {tick,PID} -> 
      PID ! {state,State + 1},
      state(State + 1);
    {read,PID} ->
      PID ! {state,State};
	{acc,PID,Value} ->
	  PID ! {state,State + Value},
	  state (State + Value)
  end. 

