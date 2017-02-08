-module(parent).
-export([start/0,set_parent/2, get_parent/1]).

start() ->
  receive 
    {set,Parent}->
      state(Parent)
  end.

get_parent(Node)->
  Node ! {get,self()},
  receive 
    {parent,P} -> P
  end.

set_parent(Node,Parent)->
   Node ! {set,Parent}.

state(Parent)->
  receive 
    {get,PID} -> 
      PID ! {parent,Parent}
  end.
