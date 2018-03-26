# play-ubuntu-18.04-ppa

* [play-ubuntu-18.04-ppa](https://samwhelp.github.io/play-ubuntu-18.04-ppa/) ([GitHub](https://github.com/samwhelp/play-ubuntu-18.04-ppa))


## Prototype Project

* [demo-repository-ubuntu](https://github.com/samwhelp/demo-repository-ubuntu)


## Usage - make


### help

``` sh
$ make
```

or

``` sh
$ make help
```


### update

``` sh
$ make update
```


### info

執行

``` sh
$ make info
```

顯示

```
ubuntu
├── dists
│   └── bionic
│       └── main
│           ├── binary-amd64
│           │   └── Packages.gz
│           ├── binary-i386
│           │   └── Packages.gz
│           └── source
│               └── Sources.gz
└── pool
    └── main
        ├── a
        ├── b
        ├── c
        ├── d
        ├── e
        ├── f
        ├── g
        ├── h
        ├── i
        ├── j
        ├── k
        ├── l
        ├── m
        ├── n
        ├── o
        ├── p
        │   └── play-lxqt
        │       ├── play-lxqt_0.1.0_all.deb
        │       ├── play-lxqt_0.1.0.dsc
        │       └── play-lxqt_0.1.0.tar.gz
        ├── q
        ├── r
        ├── s
        ├── t
        ├── u
        ├── v
        ├── w
        ├── x
        ├── y
        └── z

35 directories, 6 files
```

## Quick Start

### create /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-github.list

``` sh
$ sudo sh -c 'echo "deb [trusted=yes] https://samwhelp.github.io/play-ubuntu-18.04-ppa/ubuntu bionic main" > /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-github.list'
```

### apt-get update

``` sh
$ sudo apt-get update
```

### apt-get install

``` sh
$ sudo apt-get install play-lxqt
```


## Check Info

### apt-cahce policy

``` sh
$ apt-cache policy play-lxqt
```

### apt-cahce showpkg

``` sh
$ apt-cache showpkg play-lxqt
```


## Wget Install

### download deb

``` sh
$ wget -c 'https://samwhelp.github.io/play-ubuntu-18.04-ppa/ubuntu/pool/main/p/play-lxqt/play-lxqt_0.1.0_all.deb'
```

### dpkg -i

``` sh
$ sudo dpkg -i play-lxqt_0.1.0_all.deb
```
