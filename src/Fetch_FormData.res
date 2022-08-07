module Blob = Fetch_Blob

module EntryValue = {
  type t

  let classify = value =>
    if Js.typeof(value) == "string" {
      #String(Obj.magic(value))
    } else {
      assert false
    }
}

type t

@new external make: unit => t = "FormData"

@send external delete: (t, string) => unit = "delete"
@send external get: (t, string) => option<EntryValue.t> = "get"
@send external getAll: (t, string) => array<EntryValue.t> = "getAll"
@send external has: (t, string) => bool = "has"

@send
external append: (t, string, @unwrap [#String(string) | #Object({..}) | #Blob(Blob.t)]) => unit =
  "append"
@send
external appendWithFilename: (
  t,
  string,
  @unwrap [#String(string) | #Object({..}) | #Blob(Blob.t)],
  string,
) => unit = "append"

@send
external set: (t, string, @unwrap [#String(string) | #Object({..}) | #Blob(Blob.t)]) => unit = "set"
@send
external setWithFilename: (
  t,
  string,
  @unwrap [#String(string) | #Object({..}) | #Blob(Blob.t)],
  string,
) => unit = "set"

// @send external keys: t => Iterator.t<string> = "keys"
// @send external values: t => Iterator.t<EntryValue.t> = "values"
// @send external entries: t => Iterator.t<(string, EntryValue.t)> = "entries"}
