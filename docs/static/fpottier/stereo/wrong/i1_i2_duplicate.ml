(* Beautiful inefficient definition: *)

let rec inorder t =
  match t with
  | Leaf ->
      []
  | Node (u, x, v) ->
      inorder u @ [x] @ inorder v

let rec preorder t =
  match t with
  | Leaf ->
      []
  | Node (u, x, v) ->
      [x] @ preorder u @ preorder v

let i1, i2 =
  Node (Node (Leaf, 'a', Leaf), 'a', Leaf),
  Node (Leaf, 'a', Node (Leaf, 'a', Leaf))
