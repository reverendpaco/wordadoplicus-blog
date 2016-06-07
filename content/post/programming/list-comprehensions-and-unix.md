+++
date = "2016-06-05T05:23:39Z"
draft = true
title = "list comprehensions and unix"
tags = ["erlang","unix" ,"bash","list comprehensions"] 
categories = ["programming"]
+++

Look at the following code:

```bash
mkdir -p gameStore/{tmp,{in-use,generated,finished}/{theVelociracers/board{1,2,3,4},theVelociracersThree/board{1,2,3,4},theConstantadon,theConstantadonThree,theTherapoda,thePterodactyl}}
```
The following results:
```
gameStore/
├── finished
│   ├── theConstantadon
│   ├── theConstantadonThree
│   ├── thePterodactyl
│   ├── theTherapoda
│   ├── theVelociracers
│   │   ├── board1
│   │   ├── board2
│   │   ├── board3
│   │   └── board4
│   └── theVelociracersThree
│       ├── board1
│       ├── board2
│       ├── board3
│       └── board4
├── generated
│   ├── theConstantadon
│   ├── theConstantadonThree
│   ├── thePterodactyl
│   ├── theTherapoda
│   ├── theVelociracers
│   │   ├── board1
│   │   ├── board2
│   │   ├── board3
│   │   └── board4
│   └── theVelociracersThree
│       ├── board1
│       ├── board2
│       ├── board3
│       └── board4
├── in-use
│   ├── theConstantadon
│   ├── theConstantadonThree
│   ├── thePterodactyl
│   ├── theTherapoda
│   ├── theVelociracers
│   │   ├── board1
│   │   ├── board2
│   │   ├── board3
│   │   └── board4
│   └── theVelociracersThree
│       ├── board1
│       ├── board2
│       ├── board3
│       └── board4
└── tmp

46 directories
```

In fact, we can make this smaller:
```
mkdir -p gameStore/{tmp,{in-use,generated,finished}/{theVelociracers{,Three}/board{1,2,3,4},theCon
stantadon{,Three},theTherapoda,thePterodactyl}}
```
