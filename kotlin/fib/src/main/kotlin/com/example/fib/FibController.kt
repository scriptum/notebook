package com.example.fib

import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class FibController {
    private fun fibonacci(n: Long): Long = if (n <= 1) n else fibonacci(n - 1) + fibonacci(n - 2)

    @RequestMapping(value = ["/{number}"])
    fun fib(@PathVariable(value = "number", required = true) number: Long) = fibonacci(number)
}
