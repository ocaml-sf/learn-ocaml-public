let return (x : 'a) : 'a m =
  let compute s f = s x f in
  { compute }

let (>>=) (m1 : 'a m) (f2 : 'a -> 'b m) : 'b m =
  let compute s f = m1.compute (fun x f' -> (f2 x).compute s f') f in
  { compute }

let fail : 'a m =
  let compute s f = f() in
  { compute }

let choose (m1 : 'a m) (m2 : 'a m) : 'a m =
  let compute s f = m1.compute s (fun () -> m2.compute s f) in
  { compute }

let sols (m : 'a m) : 'a Seq.t =
  fun () ->
    m.compute
      (fun x f -> Seq.Cons (x, f))
      (fun () -> Seq.Nil)

(* The functions [reflect] and [msplit] witness an isomorphism between the
   type ['a m] and the type [unit -> ('a * 'a m) option]. *)

let reflect (o : unit -> ('a * 'a m) option) : 'a m =
  delay (fun () ->
    match o() with
    | None ->
        fail
    | Some (x, m) ->
        choose (return x) m
  )

let msplit (m : 'a m) : unit -> ('a * 'a m) option =
  fun () ->
    m.compute
      (fun x f -> Some (x, reflect f))
      (fun () -> None)

let at_most_once (m : 'a m) : 'a m =
  delay (fun () ->
    match msplit m () with
    | None ->
        fail
    | Some (x, _) ->
        return x
  )

let interleave =
  choose (* basic attempt at cheating *)
