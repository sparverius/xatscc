
datatype optn(a:type+) =
  | none(a) of ()
  | some(a) of (a)

fun<a:type><b:type>
map_list(xs:list(a), f0: a -> b) : list(b) =
(
case+ xs of
| list_nil() => list_nil()
| list_cons(x0, xs) => list_cons(f0(x0), map_list(xs, f0))
)

fun<a:type><b:type>
map_optn(xs: optn(a), f0: a -> b) : optn(b) =
(
case+ xs of
| none() => none()
| some(x) => some(f0(x))
)

#symload map with map_list
#symload map with map_optn

val xs = list_cons(1, list_cons(2, list_nil()))

val r0 = some(xs)

val r1 = map(r0, res) where val res =
  lam (k) =>
    map_list(k, lam (x) => if x % 2 = 0 then true else false)
end

(*
// type error with inner map so using map_list above
val r1 = map(zs, lam (k) => map(k, lam (x) => if x > 1 then true else false))

// however this also currently works
val r1 = map(r0, lam (k:list(int)) => map(k, lam (x) => if x > 1 then true else false))
*)
