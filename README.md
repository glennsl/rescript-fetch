# rescript-fetch
Zero-cost rescript bindings to the WHATWG Fetch API

[![npm](https://img.shields.io/npm/v/@glennsl/rescript-fetch.svg)](https://npmjs.org/@glennsl/rescript-fetch)
[![Issues](https://img.shields.io/github/issues/glennsl/rescript-fetch.svg)](https://github.com/glennsl/rescript-fetch/issues)
[![Last Commit](https://img.shields.io/github/last-commit/glennsl/rescript-fetch.svg)](https://github.com/glennsl/rescript-fetch/commits/master)


## Example

```rescript
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

### 0.2.3

* Added `Headers.getSetCookie`

### 0.2.2

* Fixed typo in `Request.credentials` binding.

### 0.2.1

* Fleshed out `AbortSignal` bindings.

### 0.2.0

* [BREAKING] Updated required minimum version of rescript to 10.1.2 in order to use the new promise type alias and async/await.
* Removed `@ryyppy/rescript-promise` dependency.

### 0.1.0
Initial release
