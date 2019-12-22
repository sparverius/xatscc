# xatscc
xanadu-lang compiler system

### Getting Started

```
git clone --recursive https://github.com/sparverius/xatscc.git
cd xatscc
sh build.sh
```

### Usage

```
./bin/xatsopt -d TEST/sieve.dats
./bin/xinterp -d TEST/sieve.dats
./bin/xjsonize -d TEST/sieve.dats
```

### Prerequisites

```
ATS2 v0.4.0
```
ATS2-0.4.0 or a later version is required,
which is available [here](http://www.ats-lang.org/Downloads.html)
