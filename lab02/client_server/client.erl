%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

-module(client).
-export([start/0]).
 
start() -> 
  receive 
    {bind, S, PID} -> next(S,PID) 
  end.
 
next(S,PID) ->
  
  Request = rand:uniform(2),

  if 
    Request == 1 -> 
      S ! {circle,1.0,PID};
    true -> 
      S ! {square,1.0,PID}
  end,  
  
  receive 
    {result, Area} -> 
      io:format("Area for ~p is ~p~n", [PID, Area]) 
  end,
  
  Sleep_time = rand:uniform(10),
  timer:sleep(Sleep_time*1000),      % pause one second before next request
  next(S,PID).

