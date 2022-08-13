# rescript-fetch
Experimental zero-cost rescript bindings to the WHATWG Fetch API

[![npm](https://img.shields.io/npm/v/@glennsl/rescript-fetch.svg)](https://npmjs.org/@glennsl/rescript-fetch)
[![Issues](https://img.shields.io/github/issues/glennsl/rescript-fetch.svg)](https://github.com/glennsl/rescript-fetch/issues)
[![Last Commit](https://img.shields.io/github/last-commit/glennsl/rescript-fetch.svg)](https://github.com/glennsl/rescript-fetch/commits/master)


## Example

```rescript
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
```

See [examples](https://github.com/glennsl/rescript-fetch/blob/master/examples/) for more.


## Installation

```sh
npm install --save @glennsl/rescript-fetch
```

Then add `@glennsl/rescript-fetch` to `bs-dependencies` in your `bsconfig.json`:

```diff
 {
   "bs-dependencies": [
+    "@glennsl/rescript-fetch"
   ]
 }
```

## Documentation

### API

For the moment, please see the interface file:

* [Fetch](https://github.com/glennsl/rescript-fetch/blob/master/src/Fetch.res)


## Changes

### 0.1.0
Initial release
