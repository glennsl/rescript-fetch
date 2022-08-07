module Signal = {
  type t

  @get external aborted: t => bool = "aborted"
  @get @return(nullable) external reason: t => option<_> = "aborted"

  @send external throwIfAborted: t => unit = "throwIfAborted"
}

module Controller = {
  type t

  @new external make: unit => t = "AbortController"

  @get external signal: t => Signal.t = "signal"

  @send external abort: (t, 'reason) => unit = "abort"
}
