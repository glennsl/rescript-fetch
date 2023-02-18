// Simple GET
let getText = async () => {
  let response = await Fetch.get("/api/hello")
  await response->Fetch.Response.text
}

// POST with JSON payload
let postJson = () => {
  let postBanana = async data => {
    open Fetch

    let response = await fetch(
      "/api/bananas",
      {
        method: #POST,
        body: data->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
        headers: Headers.fromObject({
          "Content-type": "application/json",
        }),
      },
    )

    await response->Response.json
  }

  postBanana({
    "sampledAt": Js.Date.now(),
    "cultivar": "Cavendish",
    "bunches": 10,
    "fruitsPerBunch": 20,
  })
}

// POST with FormData
let postFormData = async () => {
  open Fetch

  let formData = FormData.make()
  formData->FormData.append(
    "image0",
    #Object({"type": "image/jpg", "uri": "path/to/it", "name": "image0.jpg"}),
  )

  let response = await fetch(
    "/api/upload",
    {
      method: #POST,
      body: Body.formData(formData),
      headers: Headers.fromObject({"Accept": "*"}),
    },
  )

  await response->Response.json
}
