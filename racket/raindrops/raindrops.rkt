#lang racket

(provide convert)
(require math/number-theory)
(require axe/threading)

(define sound-of-rain '((3 . "Pling") 
  (5 . "Plang") 
  (7 . "Plong")))

(define (convert number)
  (~> sound-of-rain
    (filter-map (lambda (x) (and (divides? (car x) number) (cdr x))) _)
    (if (empty? _) (~a number) (string-append* _))))

;;; Original soln - I still quite like it for being simple 
;;; (define (convert number) 
;;;   (cond
;;;     [(and (divides? 3 number)(divides? 5 number)(divides? 7  number)) "PlingPlangPlong"]
;;;     [(and (divides? 3 number)(divides? 7 number)) "PlingPlong"]
;;;     [(and (divides? 3 number)(divides? 5 number)) "PlingPlang"]
;;;     [(and (divides? 5 number)(divides? 7 number)) "PlangPlong"]
;;;     [(divides? 3 number) "Pling"]
;;;     [(divides? 5 number) "Plang"]
;;;     [(divides? 7 number) "Plong"]
;;;     [else (~a number)]))