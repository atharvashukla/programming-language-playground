#lang racket

(require web-server/servlet
         web-server/servlet-env
         "interp1.rkt")

(define (binding-handler request)
  (define bindings (request-bindings request))
  (if (exists-binding? 'name bindings)
      (interp1 (extract-binding/single 'name bindings))
      ""))

(define (display-code request)
  `(textarea ((name "name") (id "myTextArea")(rows "20") (cols "80"))
             ,(binding-handler request)))

(define (myresponse request)
  (define bindings (request-bindings request))
  (response/xexpr
   `(html (head (title "PL Playground"))
          (body
           (h1 "Programming Language Playground")
           (form
            ,(display-code request)
            (p (input ((type "Submit"))))
            (p ,(binding-handler request)))))))

(serve/servlet myresponse #:port 8080)