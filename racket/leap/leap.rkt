#lang racket

(provide leap-year?)
(require math/number-theory)

(define (leap-year? year) 
    (or (divides? 400 year) 
    (and (divides? 4 year) (not (divides? 100 year)))))  
