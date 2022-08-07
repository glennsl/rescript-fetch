open Fetch

let _: Promise.t<Js.Json.t> = fetch(
  "/api/foo",
  {
    method: #POST,
    body: Body.Init.string(Js.Json.stringify(Js.Json.null)),
    headers: Headers.Init.object({"Content-type": "application/json"}),
  },
)->Promise.then(response => response->Response.json)
