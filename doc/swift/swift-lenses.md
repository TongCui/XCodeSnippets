## Lenses

[Lenses in Swift](http://chris.eidhof.nl/post/lenses-in-swift/)

```
struct Person {
    let name_ : String
    let address_ : Address
}

struct Address {
    let street_ : String
    let city_ : String
}
```

```
struct Lens<A,B> {
    let from : A -> B
    let to : (B, A) -> A
}
```

```
let address : Lens<Person,Address> = Lens(from: { $0.address_ }, to: {
    Person(name_: $1.name_, address_: $0)
})

let street : Lens<Address,String> = Lens(from: { $0.street_ }, to: {
    Address(street_: $0, city_: $1.city_)
})


let newAddress = street.to("My new street name", existingAddress)
```


```
func >>><A,B,C>(l: Lens<A,B>, r: Lens<B,C>) -> Lens<A,C> {
    return Lens(from: { r.from(l.from($0)) }, to: { (c, a) in
        l.to(r.to(c,l.from(a)), a)
    })
}

let personStreet = address >>> street

```
