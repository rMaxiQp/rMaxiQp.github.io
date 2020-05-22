---
layout: post
title:  "Callback, Promise, Async/Await"
date:   2020-05-21
edit:   2020-05-21
categories: [JavaScript, Note]
tags: [Language, Web]
author: Q
---

JavaScript provides three different ways to implement an asynchronous function: callback, promise, async/await.
They achieve the same goal: let the program continue while you are still waiting for an event occur.

This post will only focus on the syntax difference of using callback, promise and async/await.
Making the code simple, we want to let our program print out some strings after certain period of time.
For example, let the program print "Hello World!" after sleeping for 1 second.

If we code in Python, we can have something as following:

```.py
from time import sleep

sleep(1)
print('Hello World!')
```

Same goal can be achieved by using callback in JavaScript:

```.js
function hello_callback() {
    console.log('Hello World!')
}

// Wait for 1000 ms (1s) then invoke function hello_callback()
setTimeout(hello_callback, 1000)
```

Using promise or async/await can be little more complicated in this situation. 
setTimeout() takes a function as input and it doesn't return a Promise object. Therefore, we will need to convert setTimeout into a Promise object to align with promise or async/await's syntax.

```.js
function timeout(ms) {
    return new Promise((resolve) => {
        setTimeout(resolve, ms)
    })
}

// Do it in promise way
function hello_promise() {
    console.log('Hello World!')
}

timeout(1000).then(hello_promise)

// Do it in async/await way
async function hello_await(ms) {
    await timeout(ms)
    console.log('Hello World!')
}

hello_await(1000)
```

Reference:

- <https://javascript.info/callbacks>
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise>
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function>
