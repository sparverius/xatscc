(* ****** ****** *)

#staload
"./../xanadu\
/prelude/DATS/stream_vt.dats"

(* ****** ****** *)

impltmp
<x0>(*tmp*)
stream_vt_filter0(xs) =
(
stream_vt_mapopt0(xs)
) where
{
impltmp
mapopt0$fopr<x0><x0>(x0) = 
if
filter0$test(x0)
then optn_vt_cons(x0) else optn_vt_nil()
} endwhr

(* ****** ****** *)

fun
sieve
( xs
: stream_vt(int)) =
$llazy
(
let
val xs = !xs
in
case- xs of
|
~strmcon_vt_cons(x0, xs) =>
(
 strmcon_vt_cons
 (x0, sieve(stream_vt_filter0(xs)))
) where
{
implement
filter0$test<int>(x1) = (x1 % x0 > 0)
}
end
) (* end of [sieve] *)

(* ****** ****** *)

val
xs =
sieve(from(2)) where
{
fun
from(n) =
$llazy(strmcon_vt_cons(n, from(n+1)))
}

(* ****** ****** *)

val-
~strmcon_vt_cons(x0, xs) = !xs // x0 = 2
val-
~strmcon_vt_cons(x1, xs) = !xs // x1 = 3
val-
~strmcon_vt_cons(x2, xs) = !xs // x2 = 5
val-
~strmcon_vt_cons(x3, xs) = !xs // x3 = 7
val-
~strmcon_vt_cons(x4, xs) = !xs // x4 = 11
val-
~strmcon_vt_cons(x5, xs) = !xs // x5 = 13

(* ****** ****** *)

(* end of [sieve1_vt.dats] *)
