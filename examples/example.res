// Simple GET
let _: Promise.t<string> = Fetch.get("/api/hello")->Promise.then(Fetch.Response.text)

// POST with JSON payload
let _: Promise.t<Js.Json.t> = {
  open Fetch

  let data = Js.Json.stringifyAny({
    "sampledAt": Js.Date.now(),
    "cultivar": "Cavendish",
    "bunches": 10,
    "fruitsPerBunch": 20,
  })->Belt.Option.getExn

  fetch(
    "/api/bananas",
    {
      method: #POST,
      body: Body.Init.string(data),
      headers: Headers.Init.object({
        "Content-type": "application/json",
      }),
    },
  )->Promise.then(Response.json)
}

// POST with FormData
let _: Promise.t<Js.Json.t> = {
  open Fetch

  let formData = FormData.make()
  formData->FormData.append(
    "image0",
    #Object({"type": "image/jpg", "uri": "path/to/it", "name": "image0.jpg"}),
  )

  fetch(
    "/api/upload",
    {
      method: #POST,
      body: Body.Init.formData(formData),
      headers: Headers.Init.object({"Accept": "*"}),
    },
  )->Promise.then(Response.json)
}
