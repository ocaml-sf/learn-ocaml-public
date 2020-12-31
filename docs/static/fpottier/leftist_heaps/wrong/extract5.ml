let empty : heap =
  E

let rank (h : heap) : rank =
  match h with
  | E ->
      0
  | T (r, _, _, _) ->
      r

let makeT x h1 h2 =
  let r1 = rank h1
  and r2 = rank h2 in
  if r1 >= r2 then
    T (r2 + 1, x, h1, h2)
  else
    T (r1 + 1, x, h2, h1)

let singleton (x : element) : heap =
  makeT x empty empty
  (* T(1, x, E, E) *)

let rec union h1 h2 =
  match h1, h2 with
  | E, h
  | h, E ->
      h
  | T (_, x1, a1, b1), T (_, x2, a2, b2) ->
      if priority x1 <= priority x2 then
        makeT x1 a1 (union b1 h2)
      else
        makeT x2 a2 (union h1 b2)

let insert (x : element) (h : heap) : heap =
  union (singleton x) h

let rec extract (h : heap) : (element * heap) option =
  match h with
  | E ->
      None
  | T (r, x, h1, h2) ->
      (* Recursively extract from the left child. Makes no sense. *)
      match extract h1 with
      | None ->
          Some (x, union h1 h2)
      | Some (m, h1) ->
          Some (m, T (r, x, h1, h2))
