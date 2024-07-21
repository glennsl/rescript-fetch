module Event = {
  type t
}

module Signal = {
  type t

  /**
  https://dom.spec.whatwg.org/#dom-abortsignal-any
   */
  @scope("AbortSignal")
  external any: array<t> => t = "any"

  /**
  https://dom.spec.whatwg.org/#dom-abortsignal-timeout
   */
  @scope("AbortSignal")
  external timeout: int => t = "timeout"

  /**
  https://dom.spec.whatwg.org/#dom-abortsignal-abort
   */
  @scope("AbortSignal")
  external abort: (~reason: 'reason=?) => t = "abort"

  @get external aborted: t => bool = "aborted"
  @get @return(nullable) external reason: t => option<'reason> = "aborted"

  @send external throwIfAborted: t => unit = "throwIfAborted"

  @set external onabort: (t, Event.t => unit) => unit = "onabort"

  // inherited from EventTarget
  type addEventListenerOptions = {
    capture?: bool,
    once?: bool,
    passive?: bool,
    signal?: t,
  }

  @send
  external addEventListener: (t, @string [#abort(Event.t => unit)], ~options: addEventListenerOptions=?) => unit =
    "addEventListener"

  type removeEventListenerOptions = {
    capture?: bool,
  }

  @send
  external removeEventListener: (t, @string [#abort(Event.t => unit)], ~options: removeEventListenerOptions=?) => unit =
    "removeEventListener"
}

module Controller = {
  type t

  @new external make: unit => t = "AbortController"

  @get external signal: t => Signal.t = "signal"

  @send external abort: (t, ~reason: 'reason=?) => unit = "abort"
}
