iOS Okaymon
===

A simple Pokedex app built for teaching iOS, xCode and a little bit of Swift to web developers.

## Dependencies
* xCode 7.1.1
* [Okaymon API](https://github.com/hellobrian/okaymon)

## Pokedex.swift

```func loadPokemon(callback: ()->()) -> Void```

Will make a call to to the Okaymon API asking for a specified amount of Pokemon. It will parse the returning JSON and convert into an array of Pokemon objects.

```func getCurrent() -> Int```

Returns the index in the array specifying which Pokemon should be displayed at the time.

```func setCurrent(newCurrentIndex: Int) -> Void```

Will update the value of the index in the Pokemon array.

```func getCurrentPokemon() -> Pokemon```

Returns the current Pokemon object.

```
struct Pokemon {
    var id: Int!
    var name: String!
    var image: UIImage!
    var desc: String!
}
```
