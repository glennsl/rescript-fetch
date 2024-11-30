module AbortController = Fetch_Abort.Controller
module AbortSignal = Fetch_Abort.Signal
module AbortEvent = Fetch_Abort.Event
module Blob = Fetch_Blob
module FormData = Fetch_FormData

type method = [#GET | #HEAD | #POST | #PUT | #DELETE | #CONNECT | #OPTIONS | #TRACE | #PATCH]
type referrerPolicy = [
  | #""
  | #"no-referrer"
  | #"no-referrer-when-downgrade"
  | #"same-origin"
  | #origin
  | #"strict-origin"
  | #"origin-when-cross-origin"
  | #"strict-origin-when-cross-origin"
  | #"unsafe-url"
]
type requestDestination = [
  | #""
  | #audio
  | #audioworklet
  | #document
  | #embed
  | #font
  | #frame
  | #iframe
  | #image
  | #manifest
  | #object
  | #paintworklet
  | #report
  | #script
  | #sharedworker
  | #style
  | #track
  | #video
  | #worker
  | #xslt
]
type requestMode = [#navigate | #"same-origin" | #"no-cors" | #cors]
type requestCredentials = [#omit | #"same-origin" | #"include"]
type requestCache = [
  | #default
  | #"no-store"
  | #reload
  | #"no-cache"
  | #"force-cache"
  | #"only-if-cached"
]
type requestRedirect = [#follow | #error | #manual]
type requestDuplex = [#half]
type responseType = [#basic | #cors | #default | #error | #opaque | #opaqueredirect]

module Body = {
  type t

  external string: string => t = "%identity"
  external blob: Blob.t => t = "%identity"
  external formData: FormData.t => t = "%identity"
  // external bufferSource: bufferSource => t = "%identity"
  // external urlSearchParams: urlSearchParams => t = "%identity"
  @val external none: t = "null"
}

module Headers = {
  type t
  type init

  module Init = {
    external object: {..} => init = "%identity"
    external array: array<(string, string)> => init = "%identity"
  }

  @new external empty: t = "Headers"
  @new external make: init => t = "Headers"
  /**
   * Non-standard
   */ @new external clone: t => t = "Headers"
  @new external fromObject: {..} => t = "Headers"
  @new external fromArray: array<(string, string)> => t = "Headers"

  @send external append: (t, string, string) => unit = "append"
  @send external delete: (t, string) => unit = "delete"
  @send @return(nullable)
  external get: (t, string) => option<string> = "get"
  @send external getSetCookie: t => array<string> = "getSetCookie"
  @send external has: (t, string) => bool = "has"
  @send external set: (t, string, string) => unit = "set"

  // The following are taken from the iterable protocol spec

  /**
    * Callback arguments are (value, key, headers)
    */ @send
  external forEach: (t, @uncurry (string, string, t) => unit) => unit = "forEach"

  @send external entries: t => Js.Array.array_like<(string, string)> = "entries"
  @send external keys: t => Js.Array.array_like<string> = "keys"
  @send external values: t => Js.Array.array_like<string> = "values"
}

module Request = {
  type t
  type init = {
    method?: method,
    body?: Body.t,
    headers?: Headers.t,
    referrer?: string,
    referrerPolicy?: referrerPolicy,
    mode?: requestMode,
    credentials?: requestCredentials,
    cache?: requestCache,
    redirect?: requestRedirect,
    integrity?: string,
    keepalive?: bool,
    signal?: AbortSignal.t,
    duplex?: requestDuplex,
    // window?: any // can only be set to null
  }

  @new external make: (string, init) => t = "Request"
  @new external fromRequest: (t, init) => t = "Request"

  @get external method: t => method = "method"
  @get external url: t => string = "url"
  @get external headers: t => Headers.t = "headers"

  @get external destination: t => requestDestination = "destination"
  @get external referrer: t => string = "referrer"
  @get external referrerPolicy: t => referrerPolicy = "referrerPolicy"
  @get external mode: t => requestMode = "mode"
  @get external credentials: t => requestCredentials = "credentials"
  @get external cache: t => requestCache = "cache"
  @get external redirect: t => requestRedirect = "redirect"
  @get external integrity: t => string = "integrity"
  @get external keepalive: t => bool = "keepalive"
  @get external isReloadNavigation: t => bool = "isReloadNavigation"
  @get external isHistoryNavigation: t => bool = "isHistoryNavigation"
  @get external signal: t => AbortSignal.t = "signal"

  @send external clone: t => t = "clone"

  // Body mixin
  // @get external body: t => readableStream = "body"
  @get external bodyUsed: t => bool = "bodyUsed"
  @send external text: t => promise<string> = "text"
  @send external json: t => promise<Js.Json.t> = "json"
  @send external blob: t => promise<Blob.t> = "blob"
  @send external formData: t => promise<FormData.t> = "formData"
  // @send external arrayBuffer: t => promise<arrayBuffer> = "arrayBuffer"
}

module Response = {
  type t

  @get external type_: t => responseType = "type"

  @get external url: t => string = "url"
  @get external redirected: t => bool = "redirected"
  @get external status: t => int = "status"
  @get external ok: t => bool = "ok"
  @get external statusText: t => string = "statusText"
  @get external headers: t => Headers.t = "headers"

  @send external clone: t => t = "clone"

  // Body mixin
  // @get external body: t => readableStream = "body"
  @get external bodyUsed: t => bool = "bodyUsed"
  @send external text: t => promise<string> = "text"
  @send external json: t => promise<Js.Json.t> = "json"
  @send external blob: t => promise<Blob.t> = "blob"
  @send external formData: t => promise<FormData.t> = "formData"
  // @send external arrayBuffer: t => promise<arrayBuffer> = "arrayBuffer"
}

@val external fetch: (string, Request.init) => promise<Response.t> = "fetch"
@val external get: string => promise<Response.t> = "fetch"
@val external send: Request.t => promise<Response.t> = "fetch"
