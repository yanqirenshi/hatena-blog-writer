;;;
;;; uri
;;;
(defun hatena-blog-writer-api-root-uri (hatena-id hatena-blog-id)
  "はてなブログAtomPub のルートの URI を返す"
  (format "https://blog.hatena.ne.jp/%s/%s/atom" hatena-id hatena-blog-id))

(defun hatena-blog-writer-api-entry-uri (hatena-id hatena-blog-id &optional entry_id)
  "はてなブログAtomPub の Entry の URI を返す"
  (let* ((base-uri (hatena-blog-writer-api-root-uri hatena-id hatena-blog-id))
         (entry-uri (concat base-uri "/entry")))
    (if (null entry_id)
        entry-uri
      (format "%s/%s" entry-uri entry_id))))

(defun hatena-blog-writer-api-category-uri (hatena-id hatena-blog-id)
  "はてなブログAtomPub の カテゴリ の URI を返す"
  (concat (hatena-blog-writer-api-root-uri hatena-id hatena-blog-id)
          "/category"))

;;;
;;; header
;;;
(defun hatena-blog-writer-request-header-auth (hatena-id hatena-blog-api-key)
  "はてなブログ AtomPub の Basic認証 のためのヘッダ: Authorization の値を返す"
  (concat "Basic "
          (base64-encode-string (concat hatena-id ":" hatena-blog-api-key))))

(defun hatena-blog-writer-request-headers (hatena-id hatena-blog-api-key)
  "はてなブログ AtomPub にリクエストを投げるためのヘッダを返す"
  `(("Content-Type" . "application/x-www-form-urlencoded")
    ("Authorization" . ,(hatena-blog-writer-request-header-auth hatena-id hatena-blog-api-key))))

;;;
;;; request
;;;
(defun hatena-blog-writer-request-method2type (method)
  "method (keyword) を request.el の type (string) に変換する"
  (cond ((eq method :get) "GET")
        ((eq method :post) "POST")
        (t (error "bad method %s" method))))

(defvar *hatena-blog-writer-request-default-callback-parser*
  (lambda ()
    (xml-parse-region (point) (point-max)))
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

(defun hatena-blog-writer-request (method
                                   uri
                                   hatena-id
                                   hatena-blog-id
                                   hatena-blog-api-key
                                   funcs
                                   &optional entry-id)
  "hatena-blog-writer の request ユーティリティ関数"
  (request uri
           :type     (hatena-blog-writer-request-method2type method)
           :headers  (hatena-blog-writer-request-headers hatena-id
                                                         hatena-blog-api-key)
           :parser   (hatena-blog-writer-request-get-func funcs :parser)
           :success  (hatena-blog-writer-request-get-func funcs :success)
           :error    (hatena-blog-writer-request-get-func funcs :errro)
           :complete (hatena-blog-writer-request-get-func funcs :complete)))
