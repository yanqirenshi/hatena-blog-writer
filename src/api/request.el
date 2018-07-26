;;; -*- coding: utf-8; lexical-binding: t -*-

(defvar *hatena-blog-writer-request-default-callback-parser*
  (lambda ()
    (hatena-blog-writer-cleanup-xml
     (xml-parse-region (point) (point-max))))
  "request.el 用のデフォルトのコールバック関数")

(defvar *hatena-blog-writer-request-default-callback-success*
  (cl-function
   (lambda (&key data &allow-other-keys)
     (message "Succsess!")))
  "request.el 用のデフォルトのコールバック関数")

(defvar *hatena-blog-writer-request-default-callback-error*
  (cl-function
   (lambda (&rest args &key error-thrown &allow-other-keys)
     (message "Got error: %S" error-thrown)))
  "request.el 用のデフォルトのコールバック関数")

(defvar *hatena-blog-writer-request-default-callback-complete*
  (lambda (&rest _)
    (message "Finished!"))
  "request.el 用のデフォルトのコールバック関数")

(defun hatena-blog-writer-request-get-func (funcs type)
  "request のコールバック関数を返す。
funcsに コールバック関数 が存在しない場合はデフォルトのコールバック関数を返します。"
  (cond ((eq type :parser)
         (or (plist-get funcs :parser)
             *hatena-blog-writer-request-default-callback-parser*))
        ((eq type :success)
         (or (plist-get funcs :success)
             *hatena-blog-writer-request-default-callback-success*))
        ((eq type :error)
         (or (plist-get funcs :errro)
             *hatena-blog-writer-request-default-callback-error*))
        ((eq type :complete)
         (or (plist-get funcs :complete)
             *hatena-blog-writer-request-default-callback-complete*))))

(defun hatena-blog-writer-request-method2type (method)
  "method (keyword) を request.el の type (string) に変換する"
  (cond ((eq method :get) "GET")
        ((eq method :post) "POST")
        (t (error "bad method %s" method))))

(defun hatena-blog-writer-request (method
                                   uri
                                   hatena-id
                                   hatena-blog-id
                                   hatena-blog-api-key
                                   funcs
                                   &optional
                                   entry-id
                                   next-page)
  "hatena-blog-writer の request ユーティリティ関数"
  (request uri
           :params   (when next-page `(("next-page" . ,next-page)))
           :type     (hatena-blog-writer-request-method2type method)
           :headers  (hatena-blog-writer-request-headers hatena-id
                                                         hatena-blog-api-key)
           :parser   (hatena-blog-writer-request-get-func funcs :parser)
           :success  (hatena-blog-writer-request-get-func funcs :success)
           :error    (hatena-blog-writer-request-get-func funcs :errro)
           :complete (hatena-blog-writer-request-get-func funcs :complete)))
