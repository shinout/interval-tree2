[![Circle CI](https://circleci.com/gh/shinout/interval-tree2.svg?style=svg)](https://circleci.com/gh/shinout/interval-tree2)

# interval-tree2

interval tree in JavaScript (source is written in CoffeeScript)

## API Documentation

[latest API documentation Page (YUIDoc)](http://shinout.github.io/interval-tree2/doc/index.html)


## installation

```bash
$ npm install interval-tree2
```

## usage

```js

// add interval data

var itree = new IntervalTree(300); // 300 : the center of the tree

itree.add(22, 56,  'foo'); // 'foo' is the id of the interval data
itree.add(44, 199, 'bar'); // 'bar' is the id of the interval data

// search 1: get overlapped intervals from one point (See Interval class)
var intervals = itree.search(103);

intervals.forEach(function(interval) {
  console.log(interval.start); // overlapped interval start position
  console.log(interval.end);   // overlapped interval end position
  console.log(interval.id);    // id of the overlapped interval
});

```


```js
// search 2: get overlapped regions from a range
var intervals2 = itree.search(103, 400);

intervals2.forEach(function(interval) {
  console.log(interval.start); // overlapped interval start position
  console.log(interval.end);   // overlapped interval end position
  console.log(interval.id);    // id of the overlapped interval
});

```

