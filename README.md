# xatscc
xanadu-lang compiler system

### Prerequisites

```
ATS2 >= v0.4.0
```

### Getting Started

```
git clone --recursive https://github.com/sparverius/xatscc.git
cd xatscc
make
```

### Usage

```
./bin/xatsopt -d TEST/foldl.dats
./bin/xinterp -d TEST/foldl.dats
./bin/xjsonize -d TEST/foldl.dats
```

NOTE: xjsonize will emit the (verbose) json syntax trees for each phase of the ATS3 compilation. The stages 00, 01, 12, 23, 33, 3t... more details/explination to follow...
The results of this command can be found in a dirrectory titled 'out' in your cwd
