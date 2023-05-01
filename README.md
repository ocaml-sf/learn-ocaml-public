# learn-ocaml-public

See <https://ocaml-sf.org/learn-ocaml-public/>.

## Note to maintainers

Currently, this repo is kept up-to-date manually:

```bash
cd ../learn-ocaml-corpus
git pull
cd ../learn-ocaml-public
./deploy "$(readlink -f ../learn-ocaml-corpus)"
```

Later on, this will be automated (issue [ocaml-sf/learn-ocaml/issues#507](https://github.com/ocaml-sf/learn-ocaml/issues/507)).
