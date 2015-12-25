%%%-------------------------------------------------------------------
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(ecm_echo).

%% API
-export([
  echo/0
]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
echo() ->
  receive
    {'$gen_call', {Sender, Mref}, Request} ->
      Sender ! {Mref, Request},
      echo();
    {'$gen_cast', {Sender, Request}} ->
      Sender ! Request,
      echo();
    {Sender, Request} ->
      Sender ! Request,
      echo();
    Other ->
      ct:pal("~p", [Other])
  end,
  ok.


%%%===================================================================
%%% Internal functions
%%%===================================================================
